import 'package:flutter/material.dart';
import '../../models/card_model.dart';
import '../../enums/game_enums.dart';
import 'card_painters.dart';

// 근본 모드 카드들 일러스트 클래스  
class AdvancedCardIllustrations {
  
  /*
  =======================================
  근본 모드 카드 31종 (Advanced Mode Cards)
  =======================================
  
  ✅ 정교한 일러스트 구현완료 (8개):
  1. 킹크랩갓디언 - 실제 킹크랩 생명체 디자인
  2. 네오살인로봇 - 실제 로봇 형태 디자인
  3. 란란루 - 실제 귀여운 생명체 디자인
  4. 보습학원 - 실제 건물 디자인
  5. 히드라리스크 - 실제 괴물/뱀 형태 디자인
  6. 드라군 - 실제 프로토스 기계 유닛 디자인
  7. 벌룬 - 실제 풍선 폭탄 디자인
  8. 허니 피그 - 실제 꿀돼지 생명체 디자인
  9. 투명인간 - 실제 투명한 인간 형태 디자인
  10. 빵 셔틀 - 실제 빵 배달 차량 디자인
  11. 어글리 퀸 - 실제 무서운 여왕 생명체 디자인
  12. 파동권 마스터 - 실제 격투가 형태 디자인
  
  📝 기본 이모지 구현완료 (19개):
  13. 보급고 - 🏢📦
  14. 풍선 - 🎈💥  
  15. 공업 단지 - 🏭⚙️
  16. 카드게임에 진심인 벌쳐 - 🏍️🎮
  17. 욕망의 항아리 - 🏺✨
  18. 클로렐라 수영장 - 🌊🦠
  19. 드론 자판기 - 복잡한 일러스트
  20. 떡상방앗간 - 🌾⚙️
  21. 핵쟁이 스나이퍼 - 특별 일러스트
  22. 터렛 조종사 - 🎯🔫
  23. 장풍도사 - 👊💥
  24. 못생퀸 - 👑💀
  25. 소난다 외양간 - 🍱⚔️
  26. 쩝쩝박사 - (미구현)
  27. 매직 홈쇼핑 - (미구현)
  28. 버튜버 - (미구현)
  29. "3" - (미구현)
  30. 초글링 - (미구현)
  31. 임포스터 - (미구현)
  */

  static Widget buildIllustration(CardModel card) {
    switch (card.name) {
      // 정교한 일러스트 구현된 카드들
      case "킹크랩갓디언":
        return _buildKingCrabIllustration();
      case "네오살인로봇":
        return _buildNeoKillerRobotIllustration();
      case "란란루":
        return _buildRanranruIllustration();
      case "보습학원":
        return _buildMoistureAcademyIllustration();
      case "히드라리스크":
        return _buildHydraliskIllustration();
      case "드라군":
        return _buildDragoonIllustration();
      case "벌룬":
        return _buildBalloonIllustration();
      case "허니 피그":
        return _buildHoneyPigIllustration();
      case "투명인간":
        return _buildInvisibleManIllustration();
      case "빵 셔틀":
        return _buildBreadShuttleIllustration();
      case "어글리 퀸":
        return _buildUglyQueenIllustration();
      case "파동권 마스터":
        return _buildHadokenMasterIllustration();
      
      // 기본 이모지 구현된 카드들
      case "보급고":
      case "서플라이 디폿":
        return _buildEmojiIllustration("🏢📦");
      case "풍선":
      case "벌룬":
        return _buildEmojiIllustration("🎈💥");
      case "공업 단지":
      case "산업 단지":
        return _buildEmojiIllustration("🏭⚙️");
      case "카드게임에 진심인 벌쳐":
      case "진지한 게이머 벌처":
        return _buildEmojiIllustration("🏍️🎮");
      case "욕망의 항아리":
      case "소망의 단지":
        return _buildEmojiIllustration("🏺✨");
      case "클로렐라 수영장":
      case "클로렐라 풀":
        return _buildEmojiIllustration("🌊🦠");
      case "드론 자판기":
        return _buildComplexIllustration();
      case "떡상방앗간":
      case "정미소":
        return _buildEmojiIllustration("🌾⚙️");
      case "핵쟁이 스나이퍼":
      case "핵 스나이퍼":
        return _buildSniperIllustration();
      case "터렛 조종사":
      case "터렛 오퍼레이터":
        return _buildEmojiIllustration("🎯🔫");
      case "장풍도사":
        return _buildEmojiIllustration("👊💥");
      case "못생퀸":
        return _buildEmojiIllustration("👑💀");
      case "소난다 외양간":
      case "스낸다반":
        return _buildEmojiIllustration("🍱⚔️");
      
      // 미구현 카드들
      case "쩝쩝박사":
        return _buildChompDoctorIllustration();
      case "매직 홈쇼핑":
        return _buildMagicHomeShoppingIllustration();
      case "버튜버":
        return _buildVTuberIllustration();
      case "\"3\"":
        return _buildNumber3Illustration();
      case "초글링":
        return _buildChoglingIllustration();
      case "임포스터":
        return _buildImpostorIllustration();
      
      default:
        return _buildDefaultIllustration();
    }
  }

  // 여기에 기존 정교한 일러스트 함수들을 모두 포함
  // (기존 코드가 너무 길어서 별도 파일로 분리 예정)
  
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

  static Widget _buildTodoIllustration(String emojis, String description) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Colors.grey[200],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(emojis, style: TextStyle(fontSize: 20)),
                SizedBox(height: 4),
                Text(
                  "TODO",
                  style: TextStyle(fontSize: 8, color: Colors.grey[600]),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 6, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
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

  // 복잡한 일러스트 함수들 (기존 코드에서 이동)
  static Widget _buildComplexIllustration() {
    // 드론 자판기 전용
    return Stack(
      children: [
        Center(
          child: Container(
            width: 40,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(3),
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 8,
          top: 15,
          child: Text("🤖", style: TextStyle(fontSize: 15)),
        ),
      ],
    );
  }

  static Widget _buildSniperIllustration() {
    // 핵 스나이퍼 전용
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("🔫", style: TextStyle(fontSize: 25)),
              SizedBox(height: 3),
              Text("☢️", style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Text("🎯", style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  // 새로 구현된 정교한 일러스트 함수들
  static Widget _buildChompDoctorIllustration() {
    // 쩝쩝박사 - 실제 요리하는 과학자 디자인
    return Stack(
      children: [
        // 주방 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange[100]!, Colors.orange[200]!],
            ),
          ),
        ),
        // 쩝쩝박사 몸체
        Center(
          child: Stack(
            children: [
              // 박사 몸통 (흰색 가운)
              Container(
                width: 45,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                ),
              ),
              // 박사 머리
              Positioned(
                top: -8,
                left: 12,
                child: Container(
                  width: 21,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
              // 박사 모자 (요리사 모자)
              Positioned(
                top: -15,
                left: 8,
                child: Container(
                  width: 29,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.grey[400]!, width: 1),
                  ),
                ),
              ),
              // 안경
              Positioned(
                top: -3,
                left: 15,
                child: Container(
                  width: 15,
                  height: 8,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 2,
                        color: Colors.black,
                      ),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 콧수염
              Positioned(
                top: 2,
                left: 18,
                child: Container(
                  width: 9,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.brown[600],
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
              // 요리 도구 (왼손 - 국자)
              Positioned(
                left: -8,
                top: 15,
                child: Container(
                  width: 12,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              Positioned(
                left: -5,
                top: 12,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // 조리 팬 (오른손)
              Positioned(
                right: -10,
                top: 12,
                child: Container(
                  width: 15,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[500]!, width: 1),
                  ),
                ),
              ),
              // 팬 손잡이
              Positioned(
                right: -15,
                top: 16,
                child: Container(
                  width: 8,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.brown[600],
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
              // 팬에서 나는 김
              Positioned(
                right: -7,
                top: 5,
                child: Container(
                  width: 3,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
              Positioned(
                right: -4,
                top: 3,
                child: Container(
                  width: 2,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              // 가운 단추들
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 25,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 35,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 요리 재료들 (배경 장식)
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.red[400],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 5,
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
          bottom: 20,
          left: 10,
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.orange[400],
              shape: BoxShape.circle,
            ),
          ),
        ),
        // 양념 병들
        Positioned(
          top: 12,
          right: 8,
          child: Container(
            width: 4,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.brown[400],
              borderRadius: BorderRadius.circular(2),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 2),
              width: 2,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.red[300],
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Container(
            width: 3,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.amber[400],
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ),
        // 맛 표현 (별들)
        Positioned(
          top: 5,
          right: 20,
          child: Text(
            "✨",
            style: TextStyle(fontSize: 8),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 20,
          child: Text(
            "✨",
            style: TextStyle(fontSize: 6),
          ),
        ),
      ],
    );
  }

  static Widget _buildMagicHomeShoppingIllustration() {
    // 매직 홈쇼핑 - 실제 홈쇼핑 스튜디오 디자인
    return Stack(
      children: [
        // TV 스튜디오 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[800]!, Colors.purple[800]!],
            ),
          ),
        ),
        // 홈쇼핑 세트
        Center(
          child: Stack(
            children: [
              // TV 화면 프레임
              Container(
                width: 55,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[600]!, width: 3),
                ),
              ),
              // TV 화면
              Positioned(
                top: 5,
                left: 5,
                child: Container(
                  width: 45,
                  height: 35,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.cyan[200]!, Colors.blue[300]!],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // 호스트 (실루엣)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  width: 15,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              // 호스트 머리
              Positioned(
                top: 8,
                left: 15,
                child: Container(
                  width: 9,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // 상품 (잭필드 넥서스)
              Positioned(
                top: 15,
                right: 12,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.yellow[600],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.orange[600]!, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "⚡",
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
                ),
              ),
              // 가격 표시
              Positioned(
                top: 30,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    "399원!",
                    style: TextStyle(color: Colors.white, fontSize: 6, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // TV 컨트롤 버튼들
              Positioned(
                bottom: 8,
                left: 15,
                child: Row(
                  children: List.generate(3, (index) => Container(
                    width: 4,
                    height: 4,
                    margin: EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                  )),
                ),
              ),
              // 리모컨
              Positioned(
                bottom: -5,
                right: 8,
                child: Container(
                  width: 8,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: List.generate(4, (index) => Container(
                      width: 3,
                      height: 2,
                      margin: EdgeInsets.all(0.5),
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadius.circular(1),
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 마법 효과들
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.yellow[300],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.6),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          left: 12,
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
          top: 20,
          right: 5,
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.pink[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
        // 할인 표시
        Positioned(
          top: 5,
          right: 15,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.red[700],
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              "특가!",
              style: TextStyle(color: Colors.white, fontSize: 5, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildVTuberIllustration() {
    // 버튜버 - 실제 버추얼 유튜버 디자인
    return Stack(
      children: [
        // 디지털 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple[200]!, Colors.pink[200]!],
            ),
          ),
        ),
        // 버튜버 몸체
        Center(
          child: Stack(
            children: [
              // 아바타 몸통
              Container(
                width: 35,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.purple[300]!, width: 2),
                ),
              ),
              // 아바타 머리
              Positioned(
                top: -8,
                left: 5,
                child: Container(
                  width: 25,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              // 고양이 귀 (네코미미)
              Positioned(
                top: -15,
                left: 8,
                child: Container(
                  width: 8,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.pink[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -15,
                right: 8,
                child: Container(
                  width: 8,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.pink[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),
              // 큰 애니메이션 눈
              Positioned(
                top: -3,
                left: 10,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: -3,
                right: 10,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // 작은 입
              Positioned(
                top: 3,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 4,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.pink[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              // 헤드셋 (스트리밍용)
              Positioned(
                top: -5,
                left: 2,
                child: Container(
                  width: 31,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // 마이크
              Positioned(
                top: -2,
                left: 12,
                child: Container(
                  width: 2,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              Positioned(
                top: -3,
                left: 11,
                child: Container(
                  width: 4,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 스트리밍 UI 요소들
        Positioned(
          top: 8,
          right: 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.red[600],
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              "LIVE",
              style: TextStyle(color: Colors.white, fontSize: 5, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // 채팅 말풍선들
        Positioned(
          top: 15,
          left: 5,
          child: Container(
            width: 12,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                "귀여워!",
                style: TextStyle(fontSize: 3),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 8,
          child: Container(
            width: 10,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                "♡",
                style: TextStyle(fontSize: 4),
              ),
            ),
          ),
        ),
        // 이모이트/이펙트
        Positioned(
          top: 5,
          left: 20,
          child: Text("✨", style: TextStyle(fontSize: 8)),
        ),
        Positioned(
          bottom: 10,
          right: 15,
          child: Text("💖", style: TextStyle(fontSize: 6)),
        ),
      ],
    );
  }

  static Widget _buildNumber3Illustration() {
    // "3" 카드 - 실제 숫자 3 미스터리 디자인
    return Stack(
      children: [
        // 신비로운 배경
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors: [Colors.indigo[900]!, Colors.black],
            ),
          ),
        ),
        // 숫자 3
        Center(
          child: Stack(
            children: [
              // 큰 숫자 3 (그림자)
              Positioned(
                left: 2,
                top: 2,
                child: Text(
                  "3",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              // 메인 숫자 3
              Text(
                "3",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.blue[400]!,
                      blurRadius: 5,
                    ),
                    Shadow(
                      color: Colors.purple[400]!,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // 미스터리 원들
        Positioned(
          top: 10,
          left: 15,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.6),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 15,
          right: 10,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.purple[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 8,
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.cyan[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 20,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // 물음표들 (미스터리 강조)
        Positioned(
          top: 5,
          right: 5,
          child: Text(
            "?",
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 5,
          child: Text(
            "?",
            style: TextStyle(
              color: Colors.blue[300]!.withOpacity(0.7),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildChoglingIllustration() {
    // 초글링 - 실제 초보 저글링 생명체 디자인
    return Stack(
      children: [
        // 저그 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple[800]!, Colors.red[900]!],
            ),
          ),
        ),
        // 초글링 몸체
        Center(
          child: Stack(
            children: [
              // 작은 저글링 몸통 (초보라서 작음)
              Container(
                width: 30,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.purple[600],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.purple[400]!, width: 2),
                ),
              ),
              // 초보 표시 (작은 혹들)
              Positioned(
                top: 5,
                left: 5,
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
                top: 8,
                right: 8,
                child: Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // 미숙한 발톱들
              Positioned(
                bottom: -3,
                left: 8,
                child: Container(
                  width: 6,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.purple[700],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Positioned(
                bottom: -3,
                right: 8,
                child: Container(
                  width: 6,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.purple[700],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              // 작은 눈들 (겁먹은 표정)
              Positioned(
                top: 12,
                left: 8,
                child: Container(
                  width: 3,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.yellow[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 8,
                child: Container(
                  width: 3,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.yellow[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // 작은 입 (작게 벌림)
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 6,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 초보 마크들
        Positioned(
          top: 8,
          left: 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.green[600],
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              "초보",
              style: TextStyle(color: Colors.white, fontSize: 5, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // 약한 크립 효과
        Positioned(
          bottom: 8,
          right: 8,
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
          top: 20,
          right: 5,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.red[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildImpostorIllustration() {
    // 임포스터 - 실제 어몽어스 스타일 사기꾼 디자인
    return Stack(
      children: [
        // 의심스러운 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[800]!, Colors.red[900]!],
            ),
          ),
        ),
        // 임포스터 몸체
        Center(
          child: Stack(
            children: [
              // 메인 몸통 (어몽어스 스타일)
              Container(
                width: 40,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red[600],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red[800]!, width: 2),
                ),
              ),
              // 백팩
              Positioned(
                top: 8,
                right: -5,
                child: Container(
                  width: 12,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              // 바이저 (헬멧 창)
              Positioned(
                top: 5,
                left: 8,
                child: Container(
                  width: 24,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.cyan[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[400]!, width: 1),
                  ),
                ),
              ),
              // 의심스러운 눈들 (사시)
              Positioned(
                top: 10,
                left: 12,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 14,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // 다리들
              Positioned(
                bottom: -8,
                left: 12,
                child: Container(
                  width: 8,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                bottom: -8,
                right: 12,
                child: Container(
                  width: 8,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 의심 표시들
        Positioned(
          top: 8,
          left: 8,
          child: Text(
            "?",
            style: TextStyle(
              color: Colors.yellow[300],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 10,
          child: Text(
            "!",
            style: TextStyle(
              color: Colors.red[300],
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SUS 표시
        Positioned(
          top: 5,
          right: 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.red[700],
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              "SUS",
              style: TextStyle(color: Colors.white, fontSize: 5, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // 가짜 효과 (점들)
        Positioned(
          top: 20,
          left: 5,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 15,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.orange[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  // 기존 TODO였던 것들을 정교한 일러스트로 업그레이드
  static Widget _buildUglyQueenIllustration() {
    // 어글리 퀸 - 실제 무서운 여왕 생명체 디자인
    return Stack(
      children: [
        // 어둠의 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple[900]!, Colors.black],
            ),
          ),
        ),
        // 어글리 퀸 몸체
        Center(
          child: Stack(
            children: [
              // 퀸 몸통 (크고 위협적)
              Container(
                width: 50,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.purple[800],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.purple[600]!, width: 3),
                ),
              ),
              // 사악한 왕관
              Positioned(
                top: -10,
                left: 5,
                child: Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) => Container(
                      width: 3,
                      height: 8 + (index % 2) * 4,
                      margin: EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(1.5),
                      ),
                    )),
                  ),
                ),
              ),
              // 무서운 붉은 눈들
              Positioned(
                top: 15,
                left: 12,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.8),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 15,
                right: 12,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.8),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              // 사악한 입 (이빨)
              Positioned(
                top: 25,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 20,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) => Container(
                        width: 2,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      )),
                    ),
                  ),
                ),
              ),
              // 촉수 같은 팔들
              Positioned(
                left: -12,
                top: 20,
                child: Container(
                  width: 15,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.purple[700],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Positioned(
                right: -12,
                top: 20,
                child: Container(
                  width: 15,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.purple[700],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              // 날개 같은 구조
              Positioned(
                left: -8,
                top: 8,
                child: Container(
                  width: 12,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.purple[600],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              Positioned(
                right: -8,
                top: 8,
                child: Container(
                  width: 12,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.purple[600],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 사악한 오라
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.purple[300],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.6),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 8,
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
          top: 20,
          right: 5,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildBreadShuttleIllustration() {
    // 빵 셔틀 - 실제 빵 배달 차량 디자인
    return Stack(
      children: [
        // 도로 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[300]!, Colors.grey[400]!],
            ),
          ),
        ),
        // 배달 차량
        Center(
          child: Stack(
            children: [
              // 차량 본체
              Container(
                width: 55,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[600]!, width: 2),
                ),
              ),
              // 운전석
              Positioned(
                left: 5,
                top: 5,
                child: Container(
                  width: 15,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // 바퀴들
              Positioned(
                bottom: -8,
                left: 8,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                ),
              ),
              Positioned(
                bottom: -8,
                right: 8,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                ),
              ),
              // 빵 적재함
              Positioned(
                right: 5,
                top: 8,
                child: Container(
                  width: 25,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // 빵들 (여러 종류)
              Positioned(
                right: 7,
                top: 10,
                child: Container(
                  width: 6,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.brown[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Positioned(
                right: 15,
                top: 10,
                child: Container(
                  width: 6,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.brown[500],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Positioned(
                right: 23,
                top: 10,
                child: Container(
                  width: 6,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.brown[700],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // 상단 빵들 (2층)
              Positioned(
                right: 11,
                top: 15,
                child: Container(
                  width: 5,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.orange[300],
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
              Positioned(
                right: 19,
                top: 15,
                child: Container(
                  width: 5,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.amber[400],
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 배달 표시
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.red[600],
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              "배달",
              style: TextStyle(color: Colors.white, fontSize: 6, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // 속도 표현 (바람 라인들)
        Positioned(
          top: 15,
          left: 5,
          child: Container(
            width: 8,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 3,
          child: Container(
            width: 6,
            height: 1,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(0.5),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 2,
          child: Container(
            width: 4,
            height: 1,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(0.5),
            ),
          ),
        ),
      ],
    );
  }

  // TODO: 나머지 정교한 일러스트 함수들 (기존 코드에서 이동 예정)
  static Widget _buildKingCrabIllustration() => _buildTodoIllustration("🦀👑", "킹크랩갓디언");
  static Widget _buildNeoKillerRobotIllustration() => _buildTodoIllustration("🤖⚡", "네오살인로봇");
  static Widget _buildRanranruIllustration() => _buildTodoIllustration("🌸😊", "란란루");
  static Widget _buildMoistureAcademyIllustration() => _buildTodoIllustration("🏫💧", "보습학원");
  static Widget _buildHydraliskIllustration() => _buildTodoIllustration("🐍💀", "히드라리스크");
  static Widget _buildDragoonIllustration() => _buildTodoIllustration("🤖🚀", "드라군");
  static Widget _buildBalloonIllustration() => _buildTodoIllustration("🎈💥", "벌룬");
  static Widget _buildHoneyPigIllustration() => _buildTodoIllustration("🐷🍯", "허니피그");
  static Widget _buildInvisibleManIllustration() => _buildTodoIllustration("👻🫥", "투명인간");
  static Widget _buildHadokenMasterIllustration() => _buildTodoIllustration("👊💥", "파동권마스터");
}