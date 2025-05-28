import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '/core/util/themes.dart';
import '/features/ai_news/presentation/pages/ai_news_page.dart';
import '/features/image_detector/presentation/pages/image_classifier_page.dart';
import '/features/realtime_object_detection/presentation/pages/realtime_object_detection_page.dart';
import '/features/text_detector/presentation/pages/text_positivity_page.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'HomePage';

  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late double height;
  int selectedIndex = 0;
  late double width;
  Widget body = AINewsPage();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        body: SizedBox(
          height: height,
          child: Column(
            children: [
              // Main content area
              Expanded(
                child: body,
              ),

              // Bottom Navigation
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: appShadowColor,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: GNav(
                      onTabChange: (index) {
                        setState(() {
                          body = (index == 0 && selectedIndex != index)
                              ? AINewsPage()
                              : (index == 1 && selectedIndex != index)
                              ? TextPositivityPage()
                              : (index == 2 && selectedIndex != index)
                              ? ImageClassifierPage()
                              : (index == 3 && selectedIndex != index)
                              ? const RealTimeObjectDetectionPage()
                              : Container();
                          selectedIndex = index;
                        });
                      },
                      rippleColor: appPrimaryColor.withOpacity(0.1),
                      hoverColor: appPrimaryColor.withOpacity(0.1),
                      haptic: true,
                      curve: Curves.easeOutExpo,
                      duration: Duration(milliseconds: 300),
                      gap: 8,
                      color: appTextSecondaryColor,
                      activeColor: appPrimaryColor,
                      iconSize: 24,
                      tabBackgroundColor: appPrimaryColor.withOpacity(0.1),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      tabs: [
                        GButton(
                          icon: Icons.newspaper,
                          text: 'News',
                          iconColor: appTextSecondaryColor,
                          textColor: appPrimaryColor,
                          iconActiveColor: appPrimaryColor,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: appPrimaryColor,
                          ),
                        ),
                        GButton(
                          icon: Icons.text_fields_outlined,
                          text: 'Text',
                          iconColor: appTextSecondaryColor,
                          textColor: appPrimaryColor,
                          iconActiveColor: appPrimaryColor,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: appPrimaryColor,
                          ),
                        ),
                        GButton(
                          icon: Icons.image,
                          text: 'Image',
                          iconColor: appTextSecondaryColor,
                          textColor: appPrimaryColor,
                          iconActiveColor: appPrimaryColor,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: appPrimaryColor,
                          ),
                        ),
                        GButton(
                          icon: Icons.video_camera_back,
                          text: 'Object',
                          iconColor: appTextSecondaryColor,
                          textColor: appPrimaryColor,
                          iconActiveColor: appPrimaryColor,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: appPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}