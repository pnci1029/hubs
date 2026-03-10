import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../enums/game_enums.dart';
import 'cards/basic_illustrations.dart';
import 'cards/advanced_illustrations.dart';
import 'cards/premium_illustrations.dart';

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
    // 카드 유형별로 적절한 일러스트 모듈에서 가져오기
    
    // 프리미엄 카드들 (특별한 카드들)
    if (_isPremiumCard(card.name)) {
      return PremiumCardIllustrations.buildIllustration(card);
    }
    
    // 근본모드 카드들 (고급 카드들)
    if (_isAdvancedCard(card.name)) {
      return AdvancedCardIllustrations.buildIllustration(card);
    }
    
    // 기본 카드들 (기초 7종)
    return BasicCardIllustrations.buildIllustration(card);
  }

  bool _isPremiumCard(String cardName) {
    const premiumCards = [
      "배틀크루저",
      "시베리아 눈사람", 
      "행운의 고양이",
      "랜덤박스",
      "칼빵찔럿",
      "배틀크루저 MK-II",
      "골든 캣",
      "얼음 제왕", 
      "신비한 상자",
    ];
    return premiumCards.contains(cardName);
  }

  bool _isAdvancedCard(String cardName) {
    const advancedCards = [
      // 정교한 일러스트 구현된 카드들
      "킹크랩갓디언", "네오살인로봇", "란란루", "보습학원", "히드라리스크", "드라군",
      "벌룬", "허니 피그", "투명인간", "빵 셔틀", "어글리 퀸", "파동권 마스터",
      "쩝쩝박사", "매직 홈쇼핑", "버튜버", "\"3\"", "초글링", "임포스터",
      
      // 기본 이모지 구현된 카드들  
      "보급고", "서플라이 디폿", "풍선", "공업 단지", "산업 단지", 
      "카드게임에 진심인 벌쳐", "진지한 게이머 벌처", "욕망의 항아리", "소망의 단지",
      "클로렐라 수영장", "클로렐라 풀", "드론 자판기", "떡상방앗간", "정미소",
      "핵쟁이 스나이퍼", "핵 스나이퍼", "터렛 조종사", "터렛 오퍼레이터",
      "장풍도사", "못생퀸", "소난다 외양간", "스낸다반"
    ];
    return advancedCards.contains(cardName);
  }

  List<Color> _getCardGradient() {
    switch (card.type) {
      case CardType.resource:
        return [Colors.green[600]!, Colors.green[800]!];
      case CardType.unit:
        return [Colors.blue[600]!, Colors.blue[800]!];
      case CardType.effect:
        return [Colors.purple[600]!, Colors.purple[800]!];
      case CardType.magic:
        return [Colors.red[600]!, Colors.red[800]!];
      default:
        return [Colors.grey[600]!, Colors.grey[800]!];
    }
  }

  Color _getCardBorderColor() {
    if (card.cost <= 2) return Colors.grey[400]!; // 일반
    if (card.cost <= 5) return Colors.blue[400]!; // 레어
    if (card.cost <= 8) return Colors.purple[400]!; // 에픽
    return Colors.orange[400]!; // 레전더리
  }

  Widget _buildStat(String emoji, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: TextStyle(fontSize: width * 0.08)),
        SizedBox(width: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: width * 0.08,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}