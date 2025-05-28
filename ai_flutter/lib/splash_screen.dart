import 'dart:async';
import 'package:flutter/material.dart';
import 'core/widgets/home_layout.dart';
import 'core/util/themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Create animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Create fade-in animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(0.0, 0.65, curve: Curves.easeInOut)),
    );

    // Create scale animation
    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(0.4, 1.0, curve: Curves.easeOut)),
    );

    // Start animation
    _animationController.forward();

    // Navigate to home after 3 seconds
    Timer(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacementNamed(HomeLayout.routeName);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background gradient and particles
          Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [
                    appPrimaryColor.withOpacity(0.7),
                    appDarkBlue.withOpacity(0.5),
                    Colors.black,
                  ],
                )
            ),
          ),

          // Animated circles in background
          ...List.generate(20, (index) {
            final size = (index % 3 + 1) * 30.0;
            final left = MediaQuery.of(context).size.width * (index / 20);
            final top = MediaQuery.of(context).size.height * ((index % 5) / 5);
            final opacity = 0.1 + (index % 10) / 100;
            final color = index % 2 == 0 ? appPrimaryColor : appAccentColor;

            return Positioned(
              left: left,
              top: top,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.withOpacity(opacity * _fadeAnimation.value),
                      ),
                    ),
                  );
                },
              ),
            );
          }),

          // Main content
          Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // AI brain icon
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: appPrimaryColor.withOpacity(0.2),
                            boxShadow: [
                              BoxShadow(
                                color: appAccentColor.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.analytics,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Title
                        Text(
                          "AI ASSISTANT",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),

                        // Subtitle
                        Text(
                          "TECHNOLOGY",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                            color: appAccentColor,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Pulsing loading indicator
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(appAccentColor),
                                  strokeWidth: 2,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "LOADING",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}