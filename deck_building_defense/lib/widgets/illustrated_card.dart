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
    // 킹크랩갓디언 - 거대한 게 + 왕관
    return Stack(
      children: [
        // 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red[100]!, Colors.orange[200]!],
            ),
          ),
        ),
        // 거대한 게
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("👑", style: TextStyle(fontSize: 20)), // 왕관
              SizedBox(height: 2),
              Text("🦀", style: TextStyle(fontSize: 35)), // 큰 게
            ],
          ),
        ),
        // 방패 (가디언)
        Positioned(
          right: 8,
          top: 8,
          child: Text("🛡️", style: TextStyle(fontSize: 18)),
        ),
        // 검
        Positioned(
          left: 8,
          bottom: 8,
          child: Text("⚔️", style: TextStyle(fontSize: 15)),
        ),
      ],
    );
  }

  Widget _buildNeoKillerRobotIllustration() {
    // 네오살인로봇 - 미래형 로봇 + 레이저 + 해골
    return Stack(
      children: [
        // 배경 (사이버)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.grey[900]!],
            ),
          ),
        ),
        // 로봇
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("🤖", style: TextStyle(fontSize: 30)),
              SizedBox(height: 3),
              Text("⚡", style: TextStyle(fontSize: 15)), // 전기
            ],
          ),
        ),
        // 해골 (살인)
        Positioned(
          right: 5,
          top: 5,
          child: Text("💀", style: TextStyle(fontSize: 15)),
        ),
        // 레이저
        Positioned(
          left: 5,
          bottom: 5,
          child: Text("🔴", style: TextStyle(fontSize: 12)), // 레이저
        ),
        // Neo 표시
        Positioned(
          left: 5,
          top: 5,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text("N", style: TextStyle(color: Colors.white, fontSize: 8)),
          ),
        ),
      ],
    );
  }

  Widget _buildRanranruIllustration() {
    // 란란루 - 귀여운 캐릭터 + 기쁨 + 행동
    return Stack(
      children: [
        // 밝은 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow[100]!, Colors.pink[100]!],
            ),
          ),
        ),
        // 중앙 캐릭터
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("✨", style: TextStyle(fontSize: 12)),
              Text("😊", style: TextStyle(fontSize: 25)), // 기쁜 얼굴
              Text("🎵", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        // 파티클들
        Positioned(
          right: 8,
          top: 10,
          child: Text("💫", style: TextStyle(fontSize: 10)),
        ),
        Positioned(
          left: 8,
          top: 15,
          child: Text("⭐", style: TextStyle(fontSize: 8)),
        ),
        Positioned(
          right: 5,
          bottom: 10,
          child: Text("🌟", style: TextStyle(fontSize: 8)),
        ),
      ],
    );
  }

  Widget _buildMoistureAcademyIllustration() {
    // 보습학원 - 학교 + 물방울 + 책
    return Stack(
      children: [
        // 파란 배경 (수분)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[50]!, Colors.blue[100]!],
            ),
          ),
        ),
        // 학교 건물
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("🏫", style: TextStyle(fontSize: 25)), // 학교
              SizedBox(height: 2),
              Text("📚", style: TextStyle(fontSize: 12)), // 책들
            ],
          ),
        ),
        // 물방울들 (보습)
        Positioned(
          right: 8,
          top: 8,
          child: Text("💧", style: TextStyle(fontSize: 12)),
        ),
        Positioned(
          left: 8,
          top: 12,
          child: Text("💧", style: TextStyle(fontSize: 10)),
        ),
        Positioned(
          right: 12,
          bottom: 8,
          child: Text("💦", style: TextStyle(fontSize: 10)),
        ),
        // 선생님
        Positioned(
          left: 5,
          bottom: 5,
          child: Text("👩‍🏫", style: TextStyle(fontSize: 12)),
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