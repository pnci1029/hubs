import 'package:flutter/material.dart';
import '../../models/card_model.dart';
import '../../enums/game_enums.dart';
import 'card_painters.dart';

// 프리미엄 카드들 일러스트 클래스
class PremiumCardIllustrations {
  
  /*
  ==========================================
  프리미엄 카드들 (Premium/Special Cards)
  ==========================================
  
  ✅ 정교한 일러스트 구현완료 (4개):
  1. 배틀크루저 - 거대한 우주 전함 디자인 (cost: 11, 최상급 유닛)
  2. 시베리아 눈사람 - 러시아풍 눈사람 디자인 (cost: 6, 특수 유닛)
  3. 행운의 고양이 - 마네키네코 스타일 디자인 (cost: 9, 최고급 자원)
  4. 랜덤박스 - 미스터리 가챠 박스 디자인 (cost: 4, 효과 카드)
  
  📝 미구현 특수 카드들:
  - 행운의 고양이 variants
  - 칼빵찔럿 (cost: 2, effect)
  - 시베리아 눈사람 variants
  - 랜덤박스 variants
  - 기타 특수 이벤트 카드들
  */

  static Widget buildIllustration(CardModel card) {
    switch (card.name) {
      // 구현완료된 프리미엄 카드들
      case "배틀크루저":
        return _buildBattlecruiserIllustration();
      case "시베리아 눈사람":
        return _buildSiberianSnowmanIllustration();
      case "행운의 고양이":
        return _buildLuckyCatIllustration();
      case "랜덤박스":
        return _buildRandomBoxIllustration();
      
      // 미구현 특수 카드들
      case "칼빵찔럿":
        return _buildTodoIllustration("⚔️👽", "칼빵찔럿");
      case "배틀크루저 MK-II":
        return _buildTodoIllustration("🚀⭐", "업그레이드 전함");
      case "골든 캣":
        return _buildTodoIllustration("🐱✨", "황금 고양이");
      case "얼음 제왕":
        return _buildTodoIllustration("❄️👑", "얼음의 제왕");
      case "신비한 상자":
        return _buildTodoIllustration("📦🌟", "신비한 상자");
        
      default:
        return _buildDefaultIllustration();
    }
  }

  static Widget _buildTodoIllustration(String emojis, String description) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple[100]!, Colors.yellow[100]!],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(emojis, style: TextStyle(fontSize: 22)),
                SizedBox(height: 4),
                Text(
                  "PREMIUM",
                  style: TextStyle(
                    fontSize: 8, 
                    color: Colors.purple[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 6, color: Colors.purple[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        // 프리미엄 테두리 효과
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.yellow[600]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildDefaultIllustration() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple[200]!, Colors.blue[200]!],
            ),
          ),
        ),
        Center(
          child: Text(
            "⭐",
            style: TextStyle(fontSize: 35),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 정교한 일러스트 구현부
  // ==========================================

  static Widget _buildBattlecruiserIllustration() {
    // 배틀크루저 - 거대한 우주 전함 디자인
    return Stack(
      children: [
        // 우주 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.indigo[900]!, Colors.purple[900]!],
            ),
          ),
        ),
        // 배틀크루저 본체
        Center(
          child: Stack(
            children: [
              // 주함체 (메인 선체)
              Container(
                width: 60,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey[400]!, width: 2),
                ),
              ),
              // 함교 (상부 구조물)
              Positioned(
                top: -8,
                left: 15,
                child: Container(
                  width: 30,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.cyan[400]!, width: 1),
                  ),
                ),
              ),
              // 엔진 불꽃 (파란색)
              Positioned(
                right: -12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 11,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[400]!, Colors.cyan[200]!],
                    ),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.7),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
              // 레이저 발사 효과
              Positioned(
                top: 4,
                left: 17,
                child: Container(
                  width: 8,
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.6),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // 별들
        Positioned(
          top: 8,
          left: 10,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 8,
          child: Container(
            width: 1,
            height: 1,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildSiberianSnowmanIllustration() {
    // 시베리아 눈사람 - 러시아풍 눈사람 디자인
    return Stack(
      children: [
        // 겨울 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[100]!, Colors.white],
            ),
          ),
        ),
        // 눈사람 몸체
        Center(
          child: Stack(
            children: [
              // 몸통 (원형 눈덩이들)
              Positioned(
                bottom: -5,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 45,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!, width: 2),
                    ),
                  ),
                ),
              ),
              // 러시아 모자 (우샨카)
              Positioned(
                top: -5,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 28,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red[800]!, width: 1),
                    ),
                    child: Center(
                      child: Text(
                        "☭",
                        style: TextStyle(color: Colors.red[800], fontSize: 8),
                      ),
                    ),
                  ),
                ),
              ),
              // 당근 코
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 8,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.orange[600],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 떨어지는 눈
        Positioned(
          top: 5,
          left: 8,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildLuckyCatIllustration() {
    // 행운의 고양이 - 마네키네코 스타일 디자인
    return Stack(
      children: [
        // 황금 배경
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors: [Colors.amber[200]!, Colors.yellow[600]!, Colors.orange[400]!],
            ),
          ),
        ),
        // 고양이 몸체
        Center(
          child: Stack(
            children: [
              // 고양이 몸통
              Container(
                width: 40,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                ),
              ),
              // 행운 팔 (올라간 왼팔)
              Positioned(
                left: -8,
                top: 8,
                child: Container(
                  width: 12,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                ),
              ),
              // 목걸이/방울
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.yellow[600],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 동전들 (행운 효과)
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.yellow[600],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "¥",
                style: TextStyle(color: Colors.brown[800], fontSize: 6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildRandomBoxIllustration() {
    // 랜덤박스 - 미스터리 가챠 박스 디자인
    return Stack(
      children: [
        // 무지개 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red[400]!,
                Colors.orange[400]!,
                Colors.yellow[400]!,
                Colors.green[400]!,
                Colors.blue[400]!,
                Colors.purple[400]!,
              ],
            ),
          ),
        ),
        // 박스 몸체
        Center(
          child: Stack(
            children: [
              // 메인 박스
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.brown[600],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.brown[800]!, width: 3),
                ),
              ),
              // 자물쇠
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 8,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.yellow[600],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 큰 물음표
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "?",
                    style: TextStyle(
                      color: Colors.yellow[200],
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 2,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 반짝이는 마법 효과들
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 12,
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.pink[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}