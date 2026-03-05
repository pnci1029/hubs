import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../enums/game_enums.dart';

class IllustratedCard extends StatelessWidget {
  final CardModel card;
  final VoidCallback? onTap;
  final bool isPlayable;
  final double width;
  final double height;
  final bool showCost;

  const IllustratedCard({
    super.key,
    required this.card,
    this.onTap,
    this.isPlayable = true,
    this.width = 120,
    this.height = 160,
    this.showCost = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isPlayable ? onTap : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(color: _getCardBorderColor(), width: 2),
        ),
        child: Column(
          children: [
            // 헤더
            Container(
              height: height * 0.25,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _getCardGradient(),
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      card.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (showCost && card.cost > 0)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        width: width * 0.2,
                        height: width * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            card.cost.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // 일러스트 영역
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(6),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: _buildIllustration(),
                ),
              ),
            ),
            
            // 설명
            Container(
              height: height * 0.15,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              child: Text(
                card.description,
                style: TextStyle(fontSize: width * 0.07),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // 능력치
            Container(
              height: height * 0.2,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (card.mineral > 0) _buildStat("💎", card.mineral.toString()),
                  if (card.attack > 0) _buildStat("⚔️", card.attack.toString()),
                  if (card.hp > 0) _buildStat("❤️", card.hp.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    // 카드 이름에 따른 직관적 일러스트
    switch (card.name) {
      // 기본 7종
      case "SCV":
        return _buildEmojiIllustration("🔧⛏️");
      case "마린":
        return _buildEmojiIllustration("👨‍🚀🔫");
      case "드론":
        return _buildEmojiIllustration("🤖⚡");
      case "히드라리스크":
        return _buildEmojiIllustration("🐍💀");
      case "프로브":
        return _buildEmojiIllustration("🔮👽");
      case "드라군":
        return _buildEmojiIllustration("🤖🚀");
      case "리던던트":
        return _buildEmojiIllustration("♻️🔄");
        
      // 근본 모드 카드들
      case "서플라이 디폿":
        return _buildEmojiIllustration("🏢📦");
      case "벌룬":
        return _buildEmojiIllustration("🎈💥");
      case "산업 단지":
        return _buildEmojiIllustration("🏭⚙️");
      case "진지한 게이머 벌처":
        return _buildEmojiIllustration("🏍️🎮");
      case "허니 피그":
        return _buildEmojiIllustration("🐷🍯");
      case "소망의 단지":
        return _buildEmojiIllustration("🏺✨");
      case "투명인간":
        return _buildEmojiIllustration("👻🫥");
      case "빵 셔틀":
        return _buildEmojiIllustration("🚐🍞");
      case "클로렐라 풀":
        return _buildEmojiIllustration("🌊🦠");
      case "드론 자판기":
        return _buildComplexIllustration();
      case "정미소":
        return _buildEmojiIllustration("🌾⚙️");
      case "핵 스나이퍼":
        return _buildSniperIllustration();
      case "터렛 오퍼레이터":
        return _buildEmojiIllustration("🎯🔫");
      case "파동권 마스터":
        return _buildEmojiIllustration("👊💥");
      case "어글리 퀸":
        return _buildEmojiIllustration("👑💀");
      case "스낸다반":
        return _buildEmojiIllustration("🍱⚔️");
      case "킹크랩갓디언":
        return _buildKingCrabIllustration();
      case "네오살인로봇":
        return _buildNeoKillerRobotIllustration();
      case "란란루":
        return _buildRanranruIllustration();
      case "보습학원":
        return _buildMoistureAcademyIllustration();
      
      default:
        return Center(
          child: Text(
            "❓",
            style: TextStyle(fontSize: 30),
          ),
        );
    }
  }

  Widget _buildEmojiIllustration(String emojis) {
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

  Widget _buildComplexIllustration() {
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

  Widget _buildSniperIllustration() {
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

  Widget _buildKingCrabIllustration() {
    // 킹크랩갓디언 - Container 구조 + Icons 의미 표현
    return Stack(
      children: [
        // 메탈릭 배경 (Container의 깔끔함)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.grey[800]!, Colors.red[900]!],
            ),
          ),
        ),
        // 중앙 크랩 유닛 (Container로 구조화)
        Center(
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.red[600],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange, width: 2),
            ),
            child: Icon(
              Icons.api, // 집게발을 의미하는 직관적 아이콘
              color: Colors.orange,
              size: 35,
            ),
          ),
        ),
        // 왕관 (Icons의 직관성)
        Positioned(
          top: 25,
          left: 0,
          right: 0,
          child: Center(
            child: Icon(
              Icons.workspace_premium, // 킹/프리미엄을 의미
              color: Colors.yellow,
              size: 20,
            ),
          ),
        ),
        // 가디언 방패 (Container + Icon)
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield,
              color: Colors.white,
              size: 12,
            ),
          ),
        ),
        // 스탯 표시 (Container 정보 + Icon 의미)
        Positioned(
          bottom: 8,
          left: 8,
          child: Row(
            children: [
              Icon(Icons.flash_on, size: 12, color: Colors.red),
              Text("45", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Icon(Icons.favorite, size: 12, color: Colors.green),
              Text("60", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNeoKillerRobotIllustration() {
    // 네오살인로봇 - Container + Material Icons 하이브리드
    return Stack(
      children: [
        // 사이버 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.blue[900]!],
            ),
          ),
        ),
        // 중앙 로봇 유닛
        Center(
          child: Container(
            width: 50,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.cyan, width: 2),
            ),
            child: Stack(
              children: [
                // 로봇 메인 아이콘
                Center(
                  child: Icon(
                    Icons.smart_toy,
                    color: Colors.grey[300],
                    size: 35,
                  ),
                ),
                // 사이버 오버레이
                Center(
                  child: Icon(
                    Icons.memory,
                    color: Colors.cyan[400],
                    size: 20,
                  ),
                ),
                // 레드 바이저
                Positioned(
                  top: 12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 25,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.red[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                // 레이저 포인터들
                Positioned(
                  bottom: 15,
                  left: 12,
                  child: Icon(
                    Icons.brightness_1,
                    color: Colors.red,
                    size: 4,
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 12,
                  child: Icon(
                    Icons.brightness_1,
                    color: Colors.red,
                    size: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
        // NEO 라벨
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green[600],
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              "NEO",
              style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // 킬러 표시 (아이콘 개선)
        Positioned(
          top: 8,
          right: 8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.dangerous,
                color: Colors.red[600],
                size: 16,
              ),
              Icon(
                Icons.close,
                color: Colors.white,
                size: 8,
              ),
            ],
          ),
        ),
        // 미래 기술 표시
        Positioned(
          bottom: 25,
          right: 8,
          child: Icon(
            Icons.bolt,
            color: Colors.yellow,
            size: 12,
          ),
        ),
        // 스탯 표시 (아이콘 포함)
        Positioned(
          bottom: 8,
          left: 8,
          child: Row(
            children: [
              Icon(Icons.flash_on, size: 10, color: Colors.red),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text("40", style: TextStyle(color: Colors.white, fontSize: 8)),
              ),
              SizedBox(width: 4),
              Icon(Icons.favorite, size: 10, color: Colors.green),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text("30", style: TextStyle(color: Colors.white, fontSize: 8)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRanranruIllustration() {
    // 란란루 - Container + Material Icons 하이브리드
    return Stack(
      children: [
        // 마법적 배경
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors: [Colors.pink[200]!, Colors.purple[300]!],
            ),
          ),
        ),
        // 중앙 마법 구체
        Center(
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink[300]!, Colors.purple[400]!],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Stack(
              children: [
                // 외부 마법 링
                Center(
                  child: Icon(
                    Icons.circle,
                    color: Colors.purple[400],
                    size: 50,
                  ),
                ),
                // 내부 에너지
                Center(
                  child: Icon(
                    Icons.circle,
                    color: Colors.white.withOpacity(0.8),
                    size: 35,
                  ),
                ),
                // 핵심 에너지 (별 아이콘)
                Center(
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 15,
                  ),
                ),
                // 얼굴 - 눈들
                Positioned(
                  top: 15,
                  left: 12,
                  child: Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 4,
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 12,
                  child: Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 4,
                  ),
                ),
                // 웃는 입
                Positioned(
                  bottom: 18,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.black,
                      size: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // 마법 파티클들 (아이콘)
        Positioned(
          top: 12,
          left: 15,
          child: Icon(
            Icons.auto_awesome,
            color: Colors.yellow,
            size: 8,
          ),
        ),
        Positioned(
          top: 20,
          right: 12,
          child: Icon(
            Icons.star_outline,
            color: Colors.pink,
            size: 6,
          ),
        ),
        Positioned(
          bottom: 15,
          left: 12,
          child: Icon(
            Icons.brightness_1,
            color: Colors.white,
            size: 5,
          ),
        ),
        Positioned(
          bottom: 12,
          right: 15,
          child: Icon(
            Icons.fiber_manual_record,
            color: Colors.purple[200],
            size: 7,
          ),
        ),
        // 기쁨/마법 표시
        Positioned(
          top: 8,
          left: 8,
          child: Icon(
            Icons.sentiment_very_satisfied,
            color: Colors.yellow,
            size: 12,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Icon(
            Icons.auto_fix_high,
            color: Colors.pink,
            size: 12,
          ),
        ),
        // 스탯 표시 (아이콘 포함)
        Positioned(
          bottom: 8,
          left: 8,
          child: Row(
            children: [
              Icon(Icons.flash_on, size: 10, color: Colors.purple),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text("15", style: TextStyle(color: Colors.white, fontSize: 8)),
              ),
              SizedBox(width: 4),
              Icon(Icons.diamond, size: 10, color: Colors.yellow[600]),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text("2", style: TextStyle(color: Colors.white, fontSize: 8)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMoistureAcademyIllustration() {
    // 보습학원 - Container + Material Icons 하이브리드
    return Stack(
      children: [
        // 수분 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[100]!, Colors.cyan[200]!],
            ),
          ),
        ),
        // 중앙 건물
        Center(
          child: Container(
            width: 65,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[300]!, width: 2),
            ),
            child: Stack(
              children: [
                // 메인 학교 아이콘
                Center(
                  child: Icon(
                    Icons.school,
                    color: Colors.blue[600],
                    size: 40,
                  ),
                ),
                // 건물 윤곽선 아이콘
                Center(
                  child: Icon(
                    Icons.home_work_outlined,
                    color: Colors.grey[600],
                    size: 35,
                  ),
                ),
                // 지붕 Container
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.home,
                        color: Colors.red[600],
                        size: 10,
                      ),
                    ),
                  ),
                ),
                // 책들 아이콘
                Positioned(
                  bottom: 15,
                  left: 15,
                  child: Icon(
                    Icons.menu_book,
                    color: Colors.brown[400],
                    size: 8,
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: Icon(
                    Icons.import_contacts,
                    color: Colors.blue[800],
                    size: 8,
                  ),
                ),
              ],
            ),
          ),
        ),
        // 수분 시스템들 (아이콘)
        Positioned(
          top: 10,
          left: 10,
          child: Icon(
            Icons.water_drop,
            color: Colors.blue[600],
            size: 8,
          ),
        ),
        Positioned(
          top: 15,
          right: 15,
          child: Icon(
            Icons.water_drop,
            color: Colors.cyan[400],
            size: 6,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 12,
          child: Icon(
            Icons.opacity,
            color: Colors.blue[400],
            size: 10,
          ),
        ),
        Positioned(
          bottom: 15,
          right: 10,
          child: Icon(
            Icons.water_drop,
            color: Colors.cyan[600],
            size: 7,
          ),
        ),
        // 추가 수분 효과들
        Positioned(
          left: 8,
          top: 35,
          child: Icon(
            Icons.opacity,
            color: Colors.blue[300],
            size: 8,
          ),
        ),
        Positioned(
          right: 8,
          top: 40,
          child: Icon(
            Icons.water_drop_outlined,
            color: Colors.cyan[300],
            size: 6,
          ),
        ),
        // 아카데미 표시
        Positioned(
          top: 8,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "ACADEMY",
                style: TextStyle(color: Colors.white, fontSize: 6, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        // 교육/학습 표시
        Positioned(
          top: 8,
          left: 8,
          child: Icon(
            Icons.cast_for_education,
            color: Colors.blue[800],
            size: 12,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Icon(
            Icons.spa,
            color: Colors.green[400],
            size: 12,
          ),
        ),
        // 스탯 표시 (아이콘 포함)
        Positioned(
          bottom: 8,
          left: 8,
          child: Row(
            children: [
              Icon(Icons.favorite, size: 10, color: Colors.green),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text("20", style: TextStyle(color: Colors.white, fontSize: 8)),
              ),
              SizedBox(width: 4),
              Icon(Icons.diamond, size: 10, color: Colors.yellow[600]),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text("1", style: TextStyle(color: Colors.white, fontSize: 8)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String emoji, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: TextStyle(fontSize: width * 0.08)),
        Text(value, style: TextStyle(
          fontSize: width * 0.08, 
          fontWeight: FontWeight.bold
        )),
      ],
    );
  }

  List<Color> _getCardGradient() {
    switch (card.type) {
      case CardType.resource:
        return [Colors.green[600]!, Colors.green[800]!];
      case CardType.unit:
        return [Colors.red[600]!, Colors.red[800]!];
      case CardType.effect:
        return [Colors.blue[600]!, Colors.blue[800]!];
      case CardType.magic:
        return [Colors.purple[600]!, Colors.purple[800]!];
    }
  }

  Color _getCardBorderColor() {
    // 등급별 테두리
    if (card.cost >= 8) return Colors.amber; // 레전더리
    if (card.cost >= 5) return Colors.purple; // 에픽  
    if (card.cost >= 3) return Colors.blue; // 레어
    return Colors.grey; // 일반
  }
}