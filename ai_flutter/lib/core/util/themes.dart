
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: appBackgroundColor,
    primaryColor: appPrimaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: appPrimaryColor,
      brightness: Brightness.light,
      primary: appPrimaryColor,
      secondary: appAccentColor,
      background: appBackgroundColor,
      surface: appCardColor,
    ),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: appTextPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 28,
        letterSpacing: -0.2,
      ),
      displayMedium: TextStyle(
        color: appTextPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 24,
        letterSpacing: -0.1,
      ),
      displaySmall: TextStyle(
        color: appTextPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      headlineMedium: TextStyle(
        color: appTextPrimaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      bodyLarge: TextStyle(
        color: appTextPrimaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: appTextSecondaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: appTextSecondaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
    ),
    cardTheme: CardTheme(
      color: appCardColor,
      elevation: 2,
      shadowColor: appShadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: appBackgroundColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: appTextPrimaryColor),
      titleTextStyle: TextStyle(
        color: appTextPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: 'Poppins',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: appPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 0.5,
          fontFamily: 'Poppins',
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: appPrimaryColor,
        side: BorderSide(color: appPrimaryColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 0.5,
          fontFamily: 'Poppins',
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: appPrimaryColor,
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 0.5,
          fontFamily: 'Poppins',
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: appInputBackgroundColor,
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: appPrimaryColor, width: 1.5),
      ),
      hintStyle: TextStyle(
        color: appTextTertiaryColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      prefixIconColor: appTextSecondaryColor,
      suffixIconColor: appTextSecondaryColor,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: appChipBackgroundColor,
      disabledColor: appChipDisabledColor,
      selectedColor: appPrimaryColor,
      secondarySelectedColor: appPrimaryColor,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: TextStyle(
        color: appTextPrimaryColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: appPrimaryColor,
      unselectedItemColor: appTextTertiaryColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: appPrimaryColor,
      unselectedLabelColor: appTextSecondaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: IconThemeData(
      color: appTextPrimaryColor,
      size: 24,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: appPrimaryColor,
      circularTrackColor: appPrimaryColor.withOpacity(0.2),
    ),
    dividerTheme: DividerThemeData(
      color: appDividerColor,
      thickness: 1,
      space: 24,
    ),
    primarySwatch: createMaterialColor(appPrimaryColor),
  );
}

// Modern professional travel-inspired color scheme
var appPrimaryColor = Color(0xFF0066CC);         // Primary blue like in the travel app
var appAccentColor = Color(0xFF00AEEF);          // Secondary blue
var appTertiaryColor = Color(0xFF5AC8FA);        // Light blue accent
var appBackgroundColor = Colors.white;           // Clean white background
var appCardColor = Colors.white;                 // White card background
var appDarkBlue = Color(0xFF003B70);            // Dark blue for emphasis
var appTextPrimaryColor = Color(0xFF212121);     // Near black for primary text
var appTextSecondaryColor = Color(0xFF757575);   // Medium gray for secondary text
var appTextTertiaryColor = Color(0xFFAAAAAA);    // Light gray for hints and tertiary text
var appDividerColor = Color(0xFFEEEEEE);         // Very light gray for dividers
var appInputBackgroundColor = Color(0xFFF5F5F5); // Light gray for input backgrounds
var appChipBackgroundColor = Color(0xFFF0F0F0);  // Light gray for chip backgrounds
var appChipDisabledColor = Color(0xFFE0E0E0);    // Disabled chip color
var appShadowColor = Colors.black.withOpacity(0.1); // Subtle shadows

// Helper function to create material color from a single color
MaterialColor createMaterialColor(Color color) {
  List<double> strengths = <double>[.05, .1, .2, .3, .4, .5, .6, .7, .8, .9];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

// Pour la rétrocompatibilité (anciens noms de variables)
var aiWhite = Colors.white;
var aiPurple = appPrimaryColor;
var aiPrimaryPurple = appPrimaryColor;
var aiBlack = appTextPrimaryColor;
var aiDarkGrey = appTextSecondaryColor;
var aiGrey = appTextTertiaryColor;
var aiDarkPurple = appDarkBlue;
var aiLightPurple = appBackgroundColor;
var aiAccentPurple = appAccentColor;