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