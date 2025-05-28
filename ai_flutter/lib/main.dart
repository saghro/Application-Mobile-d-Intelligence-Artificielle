import 'package:flutter/material.dart';
import 'core/services/service_locator.dart';
import 'core/widgets/home_layout.dart';
import 'core/util/themes.dart';
import 'splash_screen.dart'; // Import the new splash screen

void main() {
  ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI App',
      theme: appTheme(),
      // Use splash screen as the initial route
      home: const SplashScreen(),
      routes: {
        HomeLayout.routeName: (context) => const HomeLayout(),
      },
    );
  }
}