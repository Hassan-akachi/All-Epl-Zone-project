// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Color definitions from CSS
  static const Color background = Color(0xFFB3D9D9);
  static const Color foreground = Color(0xFF3D5A66);
  static const Color card = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF295F75);
  static const Color primaryForeground = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF7BC4B5);
  static const Color secondaryForeground = Color(0xFF3D5A66);
  static const Color muted = Color(0xFF9FCFC0);
  static const Color accent = Color(0xFF7BC4B5);
  static const Color headerBg = Color(0xFF295F75);
  static const Color contentBg = Color(0xFF9FCFC0);
  static const Color contentBgLight = Color(0xFFB3D9D9);
  static const Color border = Color(0xFFCBE5E0);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
      surface: card,
      background: background,
      onPrimary: primaryForeground,
      onSecondary: secondaryForeground,
      onSurface: foreground,
    ),
    scaffoldBackgroundColor: contentBgLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: headerBg,
      foregroundColor: primaryForeground,
      elevation: 4,
    ),
    // cardTheme: CardTheme(
    //   elevation: 2,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   color: card,
    // ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      prefixIconColor: muted,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: primaryForeground,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: foreground,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: foreground,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: foreground,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF7BC4B5),
      secondary: Color(0xFF3D5A66),
      surface: Color(0xFF2C3E47),
      background: Color(0xFF1F2D33),
      onPrimary: Color(0xFF1F2D33),
      onSecondary: Color(0xFFE8F0F0),
      onSurface: Color(0xFFE8F0F0),
    ),
    scaffoldBackgroundColor: const Color(0xFF1F2D33),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF243742),
      foregroundColor: Color(0xFFE8F0F0),
      elevation: 4,
    ),
  );
}