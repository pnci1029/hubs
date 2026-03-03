import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumTheme {
  // 메인 컬러 팔레트 - Kingdom Rush + Arknights 영감
  static const Color primaryBlue = Color(0xFF2563EB); // 로얄 블루
  static const Color secondaryGold = Color(0xFFD97706); // 골드
  static const Color accentPurple = Color(0xFF7C3AED); // 바이올렛
  static const Color successGreen = Color(0xFF059669); // 에메랄드
  static const Color dangerRed = Color(0xFFDC2626); // 루비
  
  // 배경 & 서피스
  static const Color backgroundPrimary = Color(0xFF0F172A); // 딥 네이비
  static const Color backgroundSecondary = Color(0xFF1E293B); // 슬레이트
  static const Color backgroundMid = Color(0xFF475569); // 미드 슬레이트
  static const Color surfaceLight = Color(0xFFF8FAFC); // 거의 화이트
  static const Color surfaceDark = Color(0xFF334155); // 다크 슬레이트
  
  // 네온 컬러
  static const Color primaryNeon = Color(0xFF00D9FF); // 사이버 블루
  static const Color secondaryNeon = Color(0xFF00FF88); // 네온 그린
  
  // 텍스트
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textLight = Color(0xFFF1F5F9);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      colorScheme: const ColorScheme.dark(
        primary: primaryBlue,
        secondary: secondaryGold,
        tertiary: accentPurple,
        surface: backgroundSecondary,
        surfaceContainerHighest: backgroundPrimary,
        error: dangerRed,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textLight,
      ),
      
      // 프리미엄 타이포그래피
      textTheme: TextTheme(
        // 제목 - Cinzel (우아한 세리프)
        displayLarge: GoogleFonts.cinzel(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: secondaryGold,
          shadows: [
            const Shadow(
              color: Colors.black45,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        displayMedium: GoogleFonts.cinzel(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textLight,
        ),
        
        // 헤딩 - Orbitron (미래형 산세리프)
        headlineLarge: GoogleFonts.orbitron(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryBlue,
        ),
        headlineMedium: GoogleFonts.orbitron(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textLight,
        ),
        
        // 본문 - Noto Sans KR (한글 최적화)
        bodyLarge: GoogleFonts.notoSansKr(
          fontSize: 14,
          color: textSecondary,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.notoSansKr(
          fontSize: 12,
          color: textSecondary,
          height: 1.4,
        ),
        
        // 레이블 - Inter (모던 산세리프)
        labelLarge: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textLight,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
      ),
      
      // 앱바
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.cinzel(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: secondaryGold,
        ),
        iconTheme: const IconThemeData(
          color: primaryBlue,
          size: 24,
        ),
      ),
      
      // 카드 테마
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 4,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // 버튼 테마  
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
      ),
      
      // 아이콘 테마
      iconTheme: const IconThemeData(
        color: primaryBlue,
        size: 20,
      ),
    );
  }

  // 특별한 그라데이션들
  static const Gradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      backgroundPrimary,
      backgroundSecondary,
      Color(0xFF475569),
    ],
  );

  static const Gradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      surfaceLight,
      Color(0xFFF1F5F9),
    ],
  );

  static const Gradient goldGradient = LinearGradient(
    colors: [
      Color(0xFFFFBF00),
      Color(0xFFD97706),
      Color(0xFFB45309),
    ],
  );

  // 박스 쉐도우 프리셋
  static List<BoxShadow> get cardShadow => [
    const BoxShadow(
      color: Colors.black12,
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
    const BoxShadow(
      color: Colors.black12,
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get glowShadow => [
    BoxShadow(
      color: primaryBlue.withOpacity(0.3),
      blurRadius: 16,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> get goldGlow => [
    BoxShadow(
      color: secondaryGold.withOpacity(0.4),
      blurRadius: 20,
      spreadRadius: 3,
    ),
  ];

  // 카드별 색상 팔레트
  static Color getCardColor(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'resource':
        return successGreen;
      case 'unit':
        return dangerRed;
      case 'effect':
        return primaryBlue;
      case 'magic':
        return accentPurple;
      default:
        return textSecondary;
    }
  }

  static Color getRarityColor(int cost) {
    if (cost >= 8) return const Color(0xFFFFD700); // 레전더리 골드
    if (cost >= 5) return const Color(0xFFA855F7); // 에픽 퍼플  
    if (cost >= 3) return const Color(0xFF3B82F6); // 레어 블루
    return const Color(0xFF64748B); // 커몬 그레이
  }
}