import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../enums/game_enums.dart';

// 하트 모양을 그리는 CustomPainter
class HeartPainter extends CustomPainter {
  final Color color;

  HeartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final width = size.width;
    final height = size.height;

    // 하트 모양 경로
    path.moveTo(width / 2, height * 0.75);
    path.cubicTo(width * 0.2, height * 0.1, -width * 0.25, height * 0.6, width / 2, height);
    path.moveTo(width / 2, height * 0.75);
    path.cubicTo(width * 0.8, height * 0.1, width * 1.25, height * 0.6, width / 2, height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

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
    // 킹크랩갓디언 - 실제 킹크랩 생명체 디자인
    return Stack(
      children: [
        // 바다 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[800]!, Colors.blue[900]!],
            ),
          ),
        ),
        // 크랩 몸체 (실제 게 모양)
        Center(
          child: Stack(
            children: [
              // 게 몸통
              Container(
                width: 50,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red[600],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red[800]!, width: 2),
                ),
              ),
              // 왼쪽 집게발
              Positioned(
                left: -8,
                top: 15,
                child: Container(
                  width: 12,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              // 오른쪽 집게발
              Positioned(
                right: -8,
                top: 15,
                child: Container(
                  width: 12,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              // 게 눈
              Positioned(
                top: 8,
                left: 15,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 15,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        // 킹 왕관
        Positioned(
          top: 8,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 25,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  "♦",
                  style: TextStyle(color: Colors.red, fontSize: 8),
                ),
              ),
            ),
          ),
        ),
        // 가디언 방패
        Positioned(
          bottom: 15,
          right: 10,
          child: Container(
            width: 15,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.silver, width: 1),
            ),
            child: Center(
              child: Text(
                "+",
                style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        // 물거품 효과
        Positioned(
          top: 12,
          right: 15,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 18,
          right: 20,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNeoKillerRobotIllustration() {
    // 네오살인로봇 - 실제 로봇 형태 디자인
    return Stack(
      children: [
        // 사이버 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey[900]!, Colors.black],
            ),
          ),
        ),
        // 로봇 몸체 (실제 로봇 모양)
        Center(
          child: Stack(
            children: [
              // 로봇 몸통
              Container(
                width: 45,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.cyan[400]!, width: 2),
                ),
              ),
              // 로봇 머리
              Positioned(
                top: -8,
                left: 8,
                child: Container(
                  width: 29,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.cyan[300]!, width: 1),
                  ),
                ),
              ),
              // 로봇 눈 (LED)
              Positioned(
                top: -2,
                left: 15,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -2,
                right: 15,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
              // 로봇 팔 (왼쪽)
              Positioned(
                left: -8,
                top: 15,
                child: Container(
                  width: 8,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // 로봇 팔 (오른쪽)
              Positioned(
                right: -8,
                top: 15,
                child: Container(
                  width: 8,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // 가슴 패널
              Positioned(
                top: 18,
                left: 12,
                child: Container(
                  width: 21,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.green[400],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
              style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // 킬러 마크
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.red[600],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "!",
                style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        // 레이저 광선
        Positioned(
          bottom: 15,
          right: 5,
          child: Container(
            width: 15,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.circular(1),
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
    );
  }

  Widget _buildRanranruIllustration() {
    // 란란루 - 실제 귀여운 생명체 디자인
    return Stack(
      children: [
        // 환상적 배경
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors: [Colors.pink[100]!, Colors.purple[200]!],
            ),
          ),
        ),
        // 란란루 몸체 (실제 생명체 모양)
        Center(
          child: Stack(
            children: [
              // 둥근 몸통
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink[200]!, Colors.pink[300]!],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
              // 귀여운 얼굴 - 눈
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  width: 6,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 6,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              // 기쁜 입
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 12,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              // 작은 팔다리
              Positioned(
                left: -5,
                top: 20,
                child: Container(
                  width: 8,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.pink[200],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Positioned(
                right: -5,
                top: 20,
                child: Container(
                  width: 8,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.pink[200],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // 머리 장식 (작은 뿔 같은)
              Positioned(
                top: 5,
                left: 18,
                child: Container(
                  width: 3,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.purple[300],
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 18,
                child: Container(
                  width: 3,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.purple[300],
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 기쁨 표현 - 하트
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            width: 8,
            height: 7,
            child: CustomPaint(
              painter: HeartPainter(Colors.red[300]!),
            ),
          ),
        ),
        // 마법 파티클들
        Positioned(
          top: 15,
          right: 12,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.yellow[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 18,
          left: 10,
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
          right: 15,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMoistureAcademyIllustration() {
    // 보습학원 - 실제 건물 디자인
    return Stack(
      children: [
        // 하늘 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[200]!, Colors.blue[100]!],
            ),
          ),
        ),
        // 학원 건물 (실제 건물 모양)
        Center(
          child: Stack(
            children: [
              // 건물 본체
              Container(
                width: 55,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                ),
              ),
              // 건물 지붕
              Positioned(
                top: -8,
                left: -3,
                child: Container(
                  width: 61,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),
              // 창문들
              Positioned(
                top: 12,
                left: 8,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(color: Colors.grey[400]!, width: 1),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 8,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(color: Colors.grey[400]!, width: 1),
                  ),
                ),
              ),
              Positioned(
                top: 28,
                left: 8,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(color: Colors.grey[400]!, width: 1),
                  ),
                ),
              ),
              Positioned(
                top: 28,
                right: 8,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(color: Colors.grey[400]!, width: 1),
                  ),
                ),
              ),
              // 출입문
              Positioned(
                bottom: 0,
                left: 20,
                child: Container(
                  width: 15,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 2,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.yellow[600],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 학원 간판
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
                "보습학원",
                style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        // 수분 효과 - 스프링클러
        Positioned(
          top: 10,
          right: 8,
          child: Stack(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  shape: BoxShape.circle,
                ),
              ),
              // 물방울들
              Positioned(
                top: 8,
                left: -2,
                child: Container(
                  width: 2,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.cyan[400],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: -2,
                child: Container(
                  width: 2,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.cyan[400],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        // 습도 표시계
        Positioned(
          bottom: 15,
          left: 8,
          child: Container(
            width: 8,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.green[600],
              borderRadius: BorderRadius.circular(2),
            ),
            child: Container(
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHydraliskIllustration() {
    // 히드라리스크 - 실제 괴물/뱀 형태 디자인
    return Stack(
      children: [
        // 어두운 배경 (저그 느낌)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.purple[900]!, Colors.black],
            ),
          ),
        ),
        // 히드라리스크 몸체 (실제 뱀/괴물 모양)
        Center(
          child: Stack(
            children: [
              // 길쭉한 몸통
              Container(
                width: 35,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.purple[700],
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.purple[500]!, width: 2),
                ),
              ),
              // 머리 부분
              Positioned(
                top: -5,
                left: 5,
                child: Container(
                  width: 25,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.purple[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // 뾰족한 등골
              Positioned(
                top: 8,
                left: 15,
                child: Container(
                  width: 5,
                  height: 40,
                  child: Column(
                    children: List.generate(6, (index) => Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    )),
                  ),
                ),
              ),
              // 무서운 눈
              Positioned(
                top: 2,
                left: 8,
                child: Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.7),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 2,
                right: 8,
                child: Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.7),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              // 바늘 발사구
              Positioned(
                top: 5,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 8,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.green[800],
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 독성 효과
        Positioned(
          top: 10,
          right: 8,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.green[400],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 8,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.purple[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDragoonIllustration() {
    // 드라군 - 실제 프로토스 기계 유닛 디자인
    return Stack(
      children: [
        // 프로토스 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[800]!, Colors.indigo[900]!],
            ),
          ),
        ),
        // 드라군 기계 몸체
        Center(
          child: Stack(
            children: [
              // 하반신 다리 부분
              Container(
                width: 55,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[300]!, width: 2),
                ),
              ),
              // 상반신 조종석
              Positioned(
                top: -10,
                left: 10,
                child: Container(
                  width: 35,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.cyan, width: 1),
                  ),
                ),
              ),
              // 로봇 다리들
              Positioned(
                bottom: -5,
                left: 5,
                child: Container(
                  width: 8,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                bottom: -5,
                right: 5,
                child: Container(
                  width: 8,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                bottom: -5,
                left: 20,
                child: Container(
                  width: 8,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                bottom: -5,
                right: 20,
                child: Container(
                  width: 8,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // 주포
              Positioned(
                left: -8,
                top: 20,
                child: Container(
                  width: 20,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              // 프로토스 크리스탈
              Positioned(
                top: -5,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.cyan[400],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.withOpacity(0.7),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 에너지 효과
        Positioned(
          top: 8,
          right: 10,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBalloonIllustration() {
    // 벌룬 - 실제 풍선 폭탄 디자인
    return Stack(
      children: [
        // 하늘 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlue[200]!, Colors.blue[300]!],
            ),
          ),
        ),
        // 풍선 본체
        Center(
          child: Stack(
            children: [
              // 풍선 몸통
              Container(
                width: 45,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red[500],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.red[700]!, width: 2),
                ),
              ),
              // 풍선 하이라이트
              Positioned(
                top: 8,
                left: 10,
                child: Container(
                  width: 12,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              // 폭탄 심지
              Positioned(
                top: -8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 2,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.brown[600],
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
              // 불꽃
              Positioned(
                top: -12,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.orange[600],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.7),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 바구니
              Positioned(
                bottom: -15,
                left: 5,
                child: Container(
                  width: 35,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.brown[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 구름들
        Positioned(
          top: 12,
          left: 8,
          child: Container(
            width: 8,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 10,
          child: Container(
            width: 6,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHoneyPigIllustration() {
    // 허니 피그 - 실제 꿀돼지 생명체 디자인
    return Stack(
      children: [
        // 목초지 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[200]!, Colors.green[300]!],
            ),
          ),
        ),
        // 꿀돼지 몸체
        Center(
          child: Stack(
            children: [
              // 돼지 몸통
              Container(
                width: 50,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.pink[300],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.pink[400]!, width: 2),
                ),
              ),
              // 돼지 머리
              Positioned(
                left: -8,
                top: 5,
                child: Container(
                  width: 25,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.pink[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              // 돼지 코
              Positioned(
                left: -5,
                top: 12,
                child: Container(
                  width: 8,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.pink[400],
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 2,
                        height: 2,
                        margin: EdgeInsets.only(left: 1, top: 2),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 2,
                        margin: EdgeInsets.only(left: 2, top: 2),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 돼지 눈
              Positioned(
                left: 5,
                top: 8,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // 돼지 귀
              Positioned(
                left: 8,
                top: 2,
                child: Container(
                  width: 6,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.pink[200],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              // 꿀 단지 (등에 업고 있는)
              Positioned(
                top: -5,
                right: 5,
                child: Container(
                  width: 15,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.brown[400]!, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "꿀",
                      style: TextStyle(color: Colors.brown, fontSize: 8),
                    ),
                  ),
                ),
              ),
              // 다리들
              Positioned(
                bottom: -5,
                left: 8,
                child: Container(
                  width: 5,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.pink[400],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
              Positioned(
                bottom: -5,
                right: 8,
                child: Container(
                  width: 5,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.pink[400],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 꿀 방울들
        Positioned(
          top: 10,
          right: 8,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.amber[400],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 10,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.amber[300],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInvisibleManIllustration() {
    // 투명인간 - 실제 투명한 인간 형태 디자인
    return Stack(
      children: [
        // 어두운 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[800]!, Colors.grey[900]!],
            ),
          ),
        ),
        // 투명인간 윤곽 (점선으로 표현)
        Center(
          child: Stack(
            children: [
              // 몸통 윤곽 (점선 효과)
              Container(
                width: 40,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // 머리 윤곽
              Positioned(
                top: -15,
                left: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // 팔 윤곽
              Positioned(
                left: -8,
                top: 10,
                child: Container(
                  width: 8,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                right: -8,
                top: 10,
                child: Container(
                  width: 8,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // 다리 윤곽
              Positioned(
                bottom: -10,
                left: 12,
                child: Container(
                  width: 6,
                  height: 15,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Positioned(
                bottom: -10,
                right: 12,
                child: Container(
                  width: 6,
                  height: 15,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 투명 효과 (반짝임)
        Positioned(
          top: 15,
          left: 12,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 15,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.cyan.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 25,
          right: 20,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBreadShuttleIllustration() {
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
              // 빵들
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
        // 속도 표현
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
      ],
    );
  }

  Widget _buildUglyQueenIllustration() {
    // 어글리 퀸 - 실제 무서운 여왕 생명체 디자인
    return Stack(
      children: [
        // 어두운 성 배경
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
              // 여왕 드레스
              Container(
                width: 50,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.purple[800],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  border: Border.all(color: Colors.purple[600]!, width: 2),
                ),
              ),
              // 무서운 얼굴
              Positioned(
                top: 5,
                left: 12,
                child: Container(
                  width: 26,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // 빨간 눈
              Positioned(
                top: 10,
                left: 18,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.7),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 18,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.7),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              // 사악한 입
              Positioned(
                top: 18,
                left: 20,
                child: Container(
                  width: 10,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
              // 왕관 (어두운)
              Positioned(
                top: -8,
                left: 10,
                child: Container(
                  width: 30,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 3,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                      Container(
                        width: 3,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                      Container(
                        width: 3,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // 어둠의 오라
        Positioned(
          top: 12,
          left: 8,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.purple[400]?.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 10,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.red[400]?.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHadokenMasterIllustration() {
    // 파동권 마스터 - 실제 격투가 형태 디자인
    return Stack(
      children: [
        // 도장 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.brown[200]!, Colors.brown[400]!],
            ),
          ),
        ),
        // 격투가 몸체
        Center(
          child: Stack(
            children: [
              // 도복
              Container(
                width: 45,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                ),
              ),
              // 머리
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
              // 얼굴
              Positioned(
                top: -3,
                left: 18,
                child: Container(
                  width: 3,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              Positioned(
                top: -3,
                right: 18,
                child: Container(
                  width: 3,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              // 띠 (검은 띠)
              Positioned(
                top: 25,
                left: 5,
                child: Container(
                  width: 35,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // 파동권 포즈 - 손
              Positioned(
                right: -8,
                top: 15,
                child: Container(
                  width: 12,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // 에너지 구체 (파동권)
              Positioned(
                right: -15,
                top: 12,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [Colors.white, Colors.blue[300]!],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.6),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              // 다리
              Positioned(
                bottom: -5,
                left: 12,
                child: Container(
                  width: 8,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                bottom: -5,
                right: 12,
                child: Container(
                  width: 8,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 기 에너지 효과
        Positioned(
          top: 10,
          left: 5,
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.yellow[300]?.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 5,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.blue[300]?.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
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