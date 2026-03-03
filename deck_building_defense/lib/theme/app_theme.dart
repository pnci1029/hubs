import 'package:flutter/material.dart';

class AppTheme {
  // 메인 색상 팔레트 - 사이버펑크/판타지
  static const Color primaryNeon = Color(0xFF00D4AA); // 네온 시안
  static const Color secondaryNeon = Color(0xFFFF6B35); // 네온 오렌지
  static const Color accentPurple = Color(0xFFB06AB3); // 네온 보라
  static const Color warningYellow = Color(0xFFFFD700); // 골드
  
  // 배경 그라데이션
  static const Color backgroundDark = Color(0xFF0A0A0F); // 매우 어두운 블루
  static const Color backgroundMid = Color(0xFF161B2E); // 어두운 블루
  static const Color surfaceDark = Color(0xFF1E1E2E); // 서피스
  
  // 텍스트 색상
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB8BCC8);
  static const Color textAccent = Color(0xFF00D4AA);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // 색상 스키마
      colorScheme: const ColorScheme.dark(
        primary: primaryNeon,
        secondary: secondaryNeon,
        tertiary: accentPurple,
        surface: surfaceDark,
        surfaceVariant: backgroundMid,
        background: backgroundDark,
        error: Color(0xFFFF5555),
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: textPrimary,
        onBackground: textPrimary,
      ),
      
      // 앱바 테마
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: primaryNeon,
              blurRadius: 8,
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: primaryNeon,
        ),
      ),
      
      // 카드 테마
      cardTheme: CardThemeData(
        color: surfaceDark.withOpacity(0.7),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: primaryNeon.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      
      // 버튼 테마
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: textPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: primaryNeon,
              width: 1.5,
            ),
          ),
        ),
      ),
      
      // 텍스트 테마
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(color: primaryNeon, blurRadius: 4),
          ],
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: textSecondary,
          fontSize: 14,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 12,
        ),
      ),
      
      // 아이콘 테마
      iconTheme: const IconThemeData(
        color: primaryNeon,
        size: 24,
      ),
      
      // 스낵바 테마
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceDark,
        contentTextStyle: const TextStyle(color: textPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // 특별한 그라데이션들
  static const Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      backgroundDark,
      backgroundMid,
      Color(0xFF2A2D3A),
    ],
  );

  static const Gradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E1E2E),
      Color(0xFF16213E),
      Color(0xFF0F1419),
    ],
  );

  static const Gradient neonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryNeon,
      secondaryNeon,
      accentPurple,
    ],
  );

  // 박스 쉐도우 프리셋들
  static List<BoxShadow> get neonShadow => [
    BoxShadow(
      color: primaryNeon.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 1,
      offset: const Offset(0, 0),
    ),
  ];

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 15,
      offset: const Offset(0, 5),
    ),
    BoxShadow(
      color: primaryNeon.withOpacity(0.1),
      blurRadius: 10,
      offset: const Offset(0, 0),
    ),
  ];

  static List<BoxShadow> get glowShadow => [
    BoxShadow(
      color: primaryNeon,
      blurRadius: 30,
      spreadRadius: 3,
    ),
    BoxShadow(
      color: secondaryNeon.withOpacity(0.7),
      blurRadius: 20,
      spreadRadius: 1,
    ),
  ];
}