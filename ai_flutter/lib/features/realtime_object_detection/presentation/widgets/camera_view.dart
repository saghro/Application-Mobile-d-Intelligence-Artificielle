// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, library_private_types_in_public_api

import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../../../core/ml/realtime_object_detection_classifier/classifier.dart';
import '../../../../core/ml/realtime_object_detection_classifier/recognition.dart';
import '../../../../core/ml/realtime_object_detection_classifier/stats.dart';
import '../../../../core/util/isolate_util.dart';
import 'camera_view_singleton.dart';

/// [CameraView] sends each frame for inference
class CameraView extends StatefulWidget {
  /// Callback to pass results after inference to [HomeView]
  final Function(List<Recognition> recognitions) resultsCallback;

  /// Callback to inference stats to [HomeView]
  final Function(Stats stats) statsCallback;

  /// Constructor
  const CameraView(this.resultsCallback, this.statsCallback, {Key? key}) : super(key: key);
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  /// List of available cameras
  List<CameraDescription>? cameras;

  /// Controller
  CameraController? cameraController;

  /// true when inference is ongoing
  bool predicting = false;

  /// Instance of [Classifier]
  Classifier? classifier;

  /// Instance of [IsolateUtils]
  IsolateUtils? isolateUtils;

  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  void initStateAsync() async {
    WidgetsBinding.instance.addObserver(this);

    // Spawn a new isolate
    isolateUtils = IsolateUtils();
    await isolateUtils!.start();

    // Camera initialization
    initializeCamera();

    // Create an instance of classifier to load model and labels
    classifier = Classifier();

    // Initially predicting = false
    predicting = false;
  }

  /// Initializes the camera by setting [cameraController]
  void initializeCamera() async {
    try {
      cameras = await availableCameras();

      if (cameras == null || cameras!.isEmpty) {
        print("No cameras available!");
        // You could show a dialog or a message to the user here
        return;
      }

      // cameras[0] for rear-camera
      cameraController = CameraController(cameras![0], ResolutionPreset.low, enableAudio: false);

      await cameraController!.initialize();

      if (!mounted) return;

      // Stream of image passed to [onLatestImageAvailable] callback
      await cameraController!.startImageStream(onLatestImageAvailable);

      /// previewSize is size of each image frame captured by controller
      Size? previewSize = cameraController!.value.previewSize;
      if (previewSize == null) {
        print("Warning: Preview size is null");
        return;
      }

      /// previewSize is size of raw input image to the model
      CameraViewSingleton.inputImageSize = previewSize;

      // the display width of image on screen is
      // same as screenWidth while maintaining the aspectRatio
      if (!mounted) return;
      Size screenSize = MediaQuery.of(context).size;
      CameraViewSingleton.screenSize = screenSize;
      CameraViewSingleton.ratio = screenSize.width / previewSize.height;

      if (mounted) setState(() {});
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Return empty container while the camera is not initialized
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Center(
        child: Text(
          "Camera initializing...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      );
    }

    return AspectRatio(
        aspectRatio: cameraController!.value.aspectRatio,
        child: CameraPreview(cameraController!));
  }

  /// Callback to receive each frame [CameraImage] perform inference on it
  void onLatestImageAvailable(CameraImage cameraImage) async {
    if (classifier == null || classifier!.interpreter == null || classifier!.labels == null) {
      return;
    }

    // If previous inference has not completed then return
    if (predicting) {
      return;
    }

    setState(() {
      predicting = true;
    });

    try {
      var uiThreadTimeStart = DateTime.now().millisecondsSinceEpoch;

      // Data to be passed to inference isolate
      var isolateData = IsolateData(cameraImage, classifier!.interpreter.address, classifier!.labels);

      // We could have simply used the compute method as well however
      // it would be as in-efficient as we need to continuously passing data
      // to another isolate.

      /// perform inference in separate isolate
      Map<String, dynamic> inferenceResults = await inference(isolateData);

      var uiThreadInferenceElapsedTime = DateTime.now().millisecondsSinceEpoch - uiThreadTimeStart;

      // pass results to HomeView
      widget.resultsCallback(inferenceResults["recognitions"]);

      // pass stats to HomeView
      widget.statsCallback((inferenceResults["stats"] as Stats)..totalElapsedTime = uiThreadInferenceElapsedTime);
    } catch (e) {
      print("Error during inference: $e");
    } finally {
      // set predicting to false to allow new frames
      if (mounted) {
        setState(() {
          predicting = false;
        });
      }
    }
  }

  /// Runs inference in another isolate
  Future<Map<String, dynamic>> inference(IsolateData isolateData) async {
    if (isolateUtils == null || isolateUtils!.sendPort == null) {
      // Create Stats with all required parameters
      return {
        "recognitions": <Recognition>[],
        "stats": Stats(
            totalPredictTime: 0,
            inferenceTime: 0, preProcessingTime: 4
          // Add any other required parameters here if needed
        )
      };
    }

    ReceivePort responsePort = ReceivePort();
    isolateUtils!.sendPort.send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (cameraController == null) return;

    switch (state) {
      case AppLifecycleState.paused:
        if (cameraController!.value.isStreamingImages) {
          await cameraController!.stopImageStream();
        }
        break;
      case AppLifecycleState.resumed:
        if (!cameraController!.value.isStreamingImages) {
          await cameraController!.startImageStream(onLatestImageAvailable);
        }
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
    super.dispose();
  }
}