import 'package:flutter/material.dart';
import '../../models/card_model.dart';
import '../../enums/game_enums.dart';
import 'advanced_illustrations.dart';

// 기본 카드 7종 일러스트 클래스
class BasicCardIllustrations {
  
  /*
  ================================
  기본 카드 7종 (Original 7 Cards)
  ================================
  
  ✅ 구현완료:
  1. SCV - 기본 자원 카드 (🔧⛏️)
  2. 마린 - 기본 유닛 카드 (👨‍🚀🔫)  
  3. 드론 - 중급 자원 카드 (🤖⚡)
  4. 히드라리스크 - 중급 유닛 카드 (🐍💀)
  5. 프로브 - 고급 자원 카드 (🔮👽)
  6. 드라군 - 고급 유닛 카드 (🤖🚀)
  7. 잉여 - 쓰레기 효과 카드 (♻️🔄)
  */

  static Widget buildIllustration(CardModel card) {
    switch (card.name) {
      case "SCV":
        return _buildSCVIllustration();
      case "마린":
        return _buildMarineIllustration();
      case "드론":
        return _buildDroneIllustration();
      case "히드라리스크":
        return AdvancedCardIllustrations.buildIllustration(card);
      case "프로브":
        return _buildProbeIllustration();
      case "드라군":
        return AdvancedCardIllustrations.buildIllustration(card);
      case "잉여":
      case "리던던트":
        return _buildRedundantIllustration();
      default:
        return _buildDefaultIllustration();
    }
  }

  static Widget _buildEmojiIllustration(String emojis) {
    final emojiList = emojis.split('');
    return Stack(
      fit: StackFit.expand,
      children: [
        if (emojiList.length >= 1)
          Positioned(
            left: 10,
            top: 10,
            child: Text(emojiList[0], style: TextStyle(fontSize: 25)),
          ),
        if (emojiList.length >= 2)
          Positioned(
            right: 10,
            bottom: 10,
            child: Text(emojiList[1], style: TextStyle(fontSize: 20)),
          ),
      ],
    );
  }

  static Widget _buildDefaultIllustration() {
    return Center(
      child: Text(
        "❓",
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  // ==========================================
  // 정교한 일러스트 구현부
  // ==========================================

  static Widget _buildSCVIllustration() {
    // SCV - 기본 자원 수집 유닛
    return Stack(
      children: [
        // 건설 현장 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange[200]!, Colors.brown[300]!, Colors.grey[600]!],
            ),
          ),
        ),
        // SCV 몸체
        Center(
          child: Stack(
            children: [
              // 메인 바디 (작업용 로봇)
              Container(
                width: 35,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.orange[700]!, width: 2),
                ),
              ),
              // 조종석/헬멧
              Positioned(
                top: -5,
                left: 8,
                right: 8,
                child: Container(
                  width: 20,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: Colors.grey[900]!, width: 2),
                  ),
                ),
              ),
              // 바이저/창
              Positioned(
                top: -2,
                left: 12,
                right: 12,
                child: Container(
                  width: 12,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // 왼쪽 팔 (드릴)
              Positioned(
                left: -10,
                top: 12,
                child: Container(
                  width: 15,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.grey[800]!, width: 1),
                  ),
                  child: Column(
                    children: [
                      Expanded(flex: 3, child: Container()),
                      Container(
                        width: double.infinity,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 오른쪽 팔 (용접기/도구)
              Positioned(
                right: -10,
                top: 12,
                child: Container(
                  width: 15,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.grey[800]!, width: 1),
                  ),
                ),
              ),
              // 용접 불꽃 효과
              Positioned(
                right: -18,
                top: 18,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.orange[400],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.7),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              // 하체/캐터필러
              Positioned(
                bottom: -8,
                left: 5,
                right: 5,
                child: Container(
                  width: 25,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey[900]!, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 4,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // 작업 파편들
        Positioned(
          top: 8,
          left: 5,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.brown[400],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 10,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.grey[500],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 8,
          child: Container(
            width: 4,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.orange[300],
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildMarineIllustration() {
    // 마린 - 기본 전투 유닛
    return Stack(
      children: [
        // 전장 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.red[200]!, Colors.orange[300]!, Colors.brown[600]!],
            ),
          ),
        ),
        // 마린 몸체
        Center(
          child: Stack(
            children: [
              // 메인 바디 (파워 아머)
              Container(
                width: 30,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[900]!, width: 2),
                ),
              ),
              // 헬멧
              Positioned(
                top: -8,
                left: 5,
                right: 5,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[900]!, width: 2),
                  ),
                ),
              ),
              // 바이저
              Positioned(
                top: -5,
                left: 8,
                right: 8,
                child: Container(
                  width: 14,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // 왼쪽 어깨 패드
              Positioned(
                left: -5,
                top: 8,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.blue[800]!, width: 1),
                  ),
                ),
              ),
              // 오른쪽 어깨 패드
              Positioned(
                right: -5,
                top: 8,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.blue[800]!, width: 1),
                  ),
                ),
              ),
              // 가우스 라이플 (오른손)
              Positioned(
                right: -12,
                top: 15,
                child: Container(
                  width: 18,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey[900]!, width: 1),
                  ),
                ),
              ),
              // 총구 화염
              Positioned(
                right: -20,
                top: 17,
                child: Container(
                  width: 8,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.yellow[600],
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.7),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
              // 가슴 보호구
              Positioned(
                top: 18,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 20,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.blue[800]!, width: 1),
                    ),
                  ),
                ),
              ),
              // 다리 아머
              Positioned(
                bottom: -5,
                left: 5,
                right: 5,
                child: Container(
                  width: 20,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.blue[900]!, width: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 폭발 효과들
        Positioned(
          top: 10,
          left: 8,
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.orange[500],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.6),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 5,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.red[400],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 25,
          left: 12,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.grey[500],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildDroneIllustration() {
    // 드론 - 저그 자원 수집 유닛
    return Stack(
      children: [
        // 크립 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.purple[300]!, Colors.green[600]!, Colors.brown[700]!],
            ),
          ),
        ),
        // 드론 몸체
        Center(
          child: Stack(
            children: [
              // 메인 바디 (유기체)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.brown[600],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.brown[800]!, width: 2),
                ),
              ),
              // 등껍질 패턴
              Positioned(
                top: 8,
                left: 8,
                right: 8,
                child: Container(
                  width: 24,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.brown[500],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              // 머리/눈
              Positioned(
                top: -5,
                left: 12,
                right: 12,
                child: Container(
                  width: 16,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.brown[700],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.brown[900]!, width: 1),
                  ),
                ),
              ),
              // 복합눈
              Positioned(
                top: -2,
                left: 14,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: -2,
                right: 14,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // 왼쪽 다리/채집기
              Positioned(
                left: -8,
                top: 15,
                child: Container(
                  width: 12,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.brown[800],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        width: double.infinity,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 오른쪽 다리/채집기
              Positioned(
                right: -8,
                top: 15,
                child: Container(
                  width: 12,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.brown[800],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        width: double.infinity,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 중앙 작업 도구
              Positioned(
                bottom: -8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 8,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              // 생체 에너지 코어
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.purple[400],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.6),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 크립 입자들
        Positioned(
          top: 8,
          left: 5,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.purple[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 8,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.green[400],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 25,
          right: 12,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.brown[400],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildProbeIllustration() {
    // 프로브 - 프로토스 자원 수집 유닛
    return Stack(
      children: [
        // 프로토스 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.cyan[200]!, Colors.blue[400]!, Colors.teal[700]!],
            ),
          ),
        ),
        // 프로브 몸체
        Center(
          child: Stack(
            children: [
              // 메인 바디 (로봇)
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.cyan[600],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.cyan[800]!, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan.withOpacity(0.3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              // 중앙 에너지 코어
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue[600]!, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.8),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 왼쪽 채집 빔
              Positioned(
                left: -12,
                top: 12,
                child: Container(
                  width: 15,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.cyan[500],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.cyan[700]!, width: 1),
                  ),
                ),
              ),
              // 오른쪽 채집 빔
              Positioned(
                right: -12,
                top: 12,
                child: Container(
                  width: 15,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.cyan[500],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.cyan[700]!, width: 1),
                  ),
                ),
              ),
              // 채집 빔 효과 (왼쪽)
              Positioned(
                left: -20,
                top: 15,
                child: Container(
                  width: 8,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.yellow[400],
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.7),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              // 채집 빔 효과 (오른쪽)
              Positioned(
                right: -20,
                top: 15,
                child: Container(
                  width: 8,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.yellow[400],
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.7),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              // 하부 호버링 장치
              Positioned(
                bottom: -8,
                left: 5,
                right: 5,
                child: Container(
                  width: 25,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.cyan[700],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.cyan[900]!, width: 1),
                  ),
                ),
              ),
              // 호버링 효과
              Positioned(
                bottom: -12,
                left: 8,
                right: 8,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.cyan[300]!.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan.withOpacity(0.4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // 프로토스 에너지 파티클들
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.cyan[300],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.cyan.withOpacity(0.6),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 5,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 15,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.teal[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildRedundantIllustration() {
    // 잉여/리던던트 - 쓰레기 효과 카드
    return Stack(
      children: [
        // 폐기물 처리장 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey[300]!, Colors.brown[200]!, Colors.grey[700]!],
            ),
          ),
        ),
        // 재활용 컨테이너
        Center(
          child: Stack(
            children: [
              // 메인 쓰레기통
              Container(
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.green[600],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[800]!, width: 2),
                ),
              ),
              // 뚜껑
              Positioned(
                top: -8,
                left: -5,
                right: -5,
                child: Container(
                  width: 50,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.green[900]!, width: 2),
                  ),
                ),
              ),
              // 재활용 마크
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green[800]!, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        "♻",
                        style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 손잡이
              Positioned(
                top: 5,
                right: -8,
                child: Container(
                  width: 8,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey[800]!, width: 1),
                  ),
                ),
              ),
              // 쓰레기 조각들 (내부)
              Positioned(
                top: 30,
                left: 8,
                child: Container(
                  width: 6,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.brown[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Positioned(
                top: 32,
                right: 10,
                child: Container(
                  width: 5,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 12,
                child: Container(
                  width: 4,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 흩어진 쓰레기들
        Positioned(
          top: 10,
          left: 8,
          child: Container(
            width: 4,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.orange[400],
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 5,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.purple[300],
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ),
        Positioned(
          top: 25,
          left: 5,
          child: Container(
            width: 5,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.grey[500],
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 12,
          child: Container(
            width: 3,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.yellow[600],
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ),
        // 재활용 화살표 효과
        Positioned(
          top: 15,
          right: 8,
          child: Container(
            width: 8,
            height: 1,
            decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadius.circular(0.5),
            ),
          ),
        ),
        Positioned(
          top: 17,
          right: 6,
          child: Container(
            width: 1,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadius.circular(0.5),
            ),
          ),
        ),
      ],
    );
  }
}