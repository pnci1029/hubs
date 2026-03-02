import 'package:flutter/material.dart';
import 'dart:math' as math;

class UnitAvatar extends StatelessWidget {
  final String unitName;
  final String? cardType;
  final double size;
  final bool isDead;

  const UnitAvatar({
    super.key,
    required this.unitName,
    this.cardType,
    this.size = 40,
    this.isDead = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: _getGradient(),
        boxShadow: [
          BoxShadow(
            color: _getColor().withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 배경 패턴
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _getColor(),
                width: 2,
              ),
            ),
          ),
          // 메인 아이콘
          Center(
            child: Icon(
              _getMainIcon(),
              size: size * 0.5,
              color: Colors.white,
            ),
          ),
          // 서브 아이콘/효과
          if (_getSubIcon() != null)
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  _getSubIcon(),
                  size: size * 0.2,
                  color: Colors.white,
                ),
              ),
            ),
          // 죽음 효과
          if (isDead)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black.withOpacity(0.7),
              ),
              child: Center(
                child: Icon(
                  Icons.close,
                  size: size * 0.6,
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getColor() {
    if (cardType == "resource" || cardType == "effect" || cardType == "magic") {
      switch (cardType) {
        case "resource": return Colors.green;
        case "effect": return Colors.blue;
        case "magic": return Colors.purple;
        default: return Colors.grey;
      }
    }
    
    // 기본 7종 카드 색상
    switch (unitName) {
      case "SCV": return const Color(0xFF4A90E2); // 테란 블루
      case "마린": return const Color(0xFF2E74B5); // 진한 블루
      case "드론": return const Color(0xFF8B5CF6); // 저그 보라
      case "히드라": return const Color(0xFF7C3AED); // 진한 보라
      case "프로브": return const Color(0xFFEAB308); // 프로토스 골드
      case "드라군": return const Color(0xFFF59E0B); // 진한 골드
      case "잉여": return const Color(0xFF6B7280); // 회색
      
      // 근본 모드 카드들 (위키 정확한 31종)
      case "보급고": return const Color(0xFF4A90E2); // 테간 블루
      case "풍선": return const Color(0xFFEF4444); // 빨간색
      case "공업 단지": return const Color(0xFF059669); // 녹색
      case "카드게임에 진심인 벌쳐": return const Color(0xFFD97706); // 주황색
      case "꿀돼지": return const Color(0xFFF59E0B); // 금색
      case "욕망의 항아리": return const Color(0xFF8B5CF6); // 보라
      case "보이지 않는 남자": return const Color(0xFF1F2937); // 어두운 회색
      case "빵셔틀": return const Color(0xFF10B981); // 녹색
      case "클로렐라 수영장": return const Color(0xFF06B6D4); // 하늘색
      case "드론 자판기": return const Color(0xFF8B5CF6); // 저그 보라
      case "떡상방앗간": return const Color(0xFFEAB308); // 금색
      case "핵쟁이 스나이퍼": return const Color(0xFF1E40AF); // 블루
      case "터렛 조종사": return const Color(0xFF7C2D12); // 밤색
      case "장풍도사": return const Color(0xFF9333EA); // 밝은 보라
      case "못생퀸": return const Color(0xFF6D28D9); // 진한 보라
      case "소난다 외양간": return const Color(0xFFA855F7); // 밝은 보라
      case "킹크랩갓디언": return const Color(0xFF0EA5E9); // 하늘색
      case "쩝쩝박사": return const Color(0xFFCA8A04); // 진한 금색
      case "보습 학원": return const Color(0xFF92400E); // 어두운 금색
      case "란란루": return const Color(0xFFEC4899); // 핑크
      case "네오살인로봇": return const Color(0xFF374151); // 진한 회색
      case "매직 홈쇼핑": return const Color(0xFFFBBF24); // 밝은 노간색
      case "버튜버": return const Color(0xFFE879F9); // 매우 밝은 핑크
      case "\"3\"": return const Color(0xFF6B7280); // 회색
      case "초글링": return const Color(0xFFA855F7); // 밝은 보라
      case "임포스터": return const Color(0xFFDC2626); // 빨간색
      case "행운의 고양이": return const Color(0xFFFBBF24); // 밝은 노간색
      case "배틀크루저": return const Color(0xFF0F172A); // 진한 밤
      case "칼빵찔럿": return const Color(0xFFF59E0B); // 금색
      case "시베리아 눈사람": return const Color(0xFF0EA5E9); // 하늘색
      case "랜덤박스": return const Color(0xFF9CA3AF); // 밝은 회색
      
      default: return Colors.grey;
    }
  }

  LinearGradient _getGradient() {
    final color = _getColor();
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color.withOpacity(0.8),
        color.withOpacity(0.3),
      ],
    );
  }

  IconData _getMainIcon() {
    if (cardType == "resource") return Icons.diamond;
    if (cardType == "effect") return Icons.auto_fix_high;
    if (cardType == "magic") return Icons.star;
    
    // 기본 7종 카드 아이콘
    switch (unitName) {
      case "SCV": return Icons.construction; // 건설 아이콘
      case "마린": return Icons.military_tech; // 군사 아이콘
      case "드론": return Icons.bug_report; // 벌레 모양
      case "히드라": return Icons.pest_control; // 해충 모양
      case "프로브": return Icons.science; // 과학 아이콘
      case "드라군": return Icons.smart_toy; // 로봇 모양
      case "잉여": return Icons.help_outline; // 물음표
      
      // 근본 모드 카드들 아이콘
      case "보급고": return Icons.home; // 집
      case "풍선": return Icons.air; // 공기
      case "공업 단지": return Icons.factory; // 공장
      case "카드게임에 진심인 벌쳐": return Icons.speed; // 속도
      case "꿀돼지": return Icons.pets; // 애완동물
      case "욕망의 항아리": return Icons.local_drink; // 음료
      case "보이지 않는 남자": return Icons.visibility_off; // 투명
      case "빵셔틀": return Icons.delivery_dining; // 배달
      case "클로렐라 수영장": return Icons.pool; // 수영장
      case "드론 자판기": return Icons.local_mall; // 쇼핑
      case "떡상방앗간": return Icons.trending_up; // 상승
      case "핵쟁이 스나이퍼": return Icons.gps_fixed; // 조준
      case "터렛 조종사": return Icons.control_camera; // 제어
      case "장풍도사": return Icons.waves; // 파동
      case "못생퀸": return Icons.female; // 여성
      case "소난다 외양간": return Icons.home_work; // 농장
      case "킹크랩갓디언": return Icons.shield; // 방패
      case "쩝쩝박사": return Icons.restaurant; // 음식
      case "보습 학원": return Icons.school; // 학교
      case "란란루": return Icons.celebration; // 축하
      case "네오살인로봇": return Icons.android; // 안드로이드
      case "매직 홈쇼핑": return Icons.shopping_cart; // 쇼핑카트
      case "버튜버": return Icons.videocam; // 비디오
      case "\"3\"": return Icons.filter_3; // 숫자 3
      case "초글링": return Icons.child_friendly; // 어린이
      case "임포스터": return Icons.person_search; // 검색
      case "행운의 고양이": return Icons.pets; // 고양이
      case "배틀크루저": return Icons.rocket_launch; // 로켓
      case "칼빵찔럿": return Icons.sports_martial_arts; // 무예
      case "시베리아 눈사람": return Icons.ac_unit; // 눈
      case "랜덤박스": return Icons.casino; // 도박
      
      default: return Icons.help;
    }
  }

  IconData? _getSubIcon() {
    if (cardType != "unit") return null;
    
    // 소수 주요 카드들만 서브 아이콘 제공
    switch (unitName) {
      case "마린": return Icons.radio_button_checked; // 총
      case "네오살인로봇": return Icons.warning; // 경고
      case "배틀크루저": return Icons.star; // 특별
      case "임포스터": return Icons.dangerous; // 위험
      default: return null;
    }
  }
}
