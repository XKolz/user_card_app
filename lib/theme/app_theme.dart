import 'package:flutter/material.dart';

class AppTheme {
  // App colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF03DAC5);
  static const Color darkTextColor = Color(0xFF2D3142);
  static const Color backgroundColor = Color(0xFFF5F7FA);
  static const Color redColor = Color(0xFFFF7597);
  static const Color orangeColor = Color(0xFFFFB55F);

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      secondary: secondaryColor,
    ),
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16.0),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
    ),
    scaffoldBackgroundColor: backgroundColor,
  );
}