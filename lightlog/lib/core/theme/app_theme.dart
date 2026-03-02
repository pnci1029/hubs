import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF6B73FF);
  static const Color _backgroundColor = Color(0xFFFAFAFA);
  static const Color _surfaceColor = Color(0xFFFFFFFF);
  static const Color _textPrimary = Color(0xFF1A1A1A);
  static const Color _textSecondary = Color(0xFF666666);
  static const Color _textHint = Color(0xFF999999);
  static const Color _borderColor = Color(0xFFE5E5E5);
  static const Color _successColor = Color(0xFF4CAF50);
  static const Color _warningColor = Color(0xFFFF9800);
  static const Color _errorColor = Color(0xFFF44336);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Pretendard',
    colorScheme: const ColorScheme.light(
      primary: _primaryColor,
      secondary: Color(0xFF8B92FF),
      surface: _surfaceColor,
      background: _backgroundColor,
      error: _errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _textPrimary,
      onBackground: _textPrimary,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: _backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: _backgroundColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: _textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: _textPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        minimumSize: const Size(120, 48),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryColor,
        side: const BorderSide(color: _borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        minimumSize: const Size(120, 48),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _errorColor),
      ),
      contentPadding: const EdgeInsets.all(16),
      hintStyle: const TextStyle(color: _textHint),
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      color: _surfaceColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _surfaceColor,
      selectedItemColor: _primaryColor,
      unselectedItemColor: _textHint,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );

  static const EdgeInsets paddingSmall = EdgeInsets.all(8);
  static const EdgeInsets paddingMedium = EdgeInsets.all(16);
  static const EdgeInsets paddingLarge = EdgeInsets.all(24);

  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;

  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: _textPrimary,
    height: 1.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: _textPrimary,
    height: 1.3,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: _textPrimary,
    height: 1.3,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: _textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _textPrimary,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: _textSecondary,
    height: 1.3,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: _textHint,
    height: 1.2,
  );
}