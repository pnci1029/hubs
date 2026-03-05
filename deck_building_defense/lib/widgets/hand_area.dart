import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../providers/game_provider.dart';
import '../models/card_model.dart';
import '../enums/game_enums.dart';
import '../widgets/illustrated_card.dart';
import '../services/sound_service.dart';
import '../theme/premium_theme.dart';

class HandArea extends StatelessWidget {
  const HandArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  PremiumTheme.backgroundMid.withOpacity(0.4),
                  PremiumTheme.surfaceDark.withOpacity(0.3),
                  Colors.black.withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: PremiumTheme.secondaryNeon.withOpacity(0.3),
                width: 1,
              ),
            ),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.pan_tool, color: PremiumTheme.secondaryNeon, size: 24),
                const SizedBox(width: 8),
                Text(
                  "손패",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Consumer<GameProvider>(
                  builder: (context, gameProvider, child) {
                    return Text(
                      "${gameProvider.hand.length}/32",
                      style: const TextStyle(color: Colors.white70),
                    );
                  },
                ),
              ],
            ),
          ),
          
          // 카드들
          Expanded(
            child: Consumer<GameProvider>(
              builder: (context, gameProvider, child) {
                if (gameProvider.hand.isEmpty) {
                  return const Center(
                    child: Text(
                      "손패가 비어있습니다",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: gameProvider.hand.length,
                  itemBuilder: (context, index) {
                    final card = gameProvider.hand[index];
                    return IllustratedCard(
                      card: card,
                      onTap: () => _onCardTap(card, gameProvider),
                      isPlayable: gameProvider.isRoundActive || card.type != CardType.unit,
                      width: 100,
                      height: 130,
                    ).animate().slideX(
                      begin: 1.0,
                      duration: Duration(milliseconds: 300 + (index * 50)),
                      curve: Curves.easeOutBack,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
          ),
        ),
      ),
    );
  }

  Widget _buildHandCard(BuildContext context, CardModel card, GameProvider gameProvider) {
    final canPlay = gameProvider.isRoundActive || card.type != CardType.unit;
    
    return GestureDetector(
      onTap: canPlay ? () => _onCardTap(card, gameProvider) : null,
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        decoration: BoxDecoration(
          color: _getCardBackgroundColor(card.type).withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: canPlay 
                ? _getCardBorderColor(card.type)
                : Colors.grey.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            // 카드 내용
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 카드 타입 아이콘
                  Icon(
                    _getCardIcon(card.type),
                    color: _getCardBorderColor(card.type),
                    size: 14,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // 카드 이름
                  Text(
                    card.name,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const Spacer(),
                  
                  // 카드 능력치
                  if (card.mineral > 0) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.diamond, color: Colors.yellow, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          "${card.mineral}",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                  
                  if (card.attack > 0) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.flash_on, color: Colors.red, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          "${card.attack + (gameProvider.upgrade * card.attack * 0.2).round()}",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            // 비용 표시
            if (card.cost > 0)
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "${card.cost}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            
            // 사용 불가능 오버레이
            if (!canPlay)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.block,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onCardTap(CardModel card, GameProvider gameProvider) {
    SoundService().playCardPlay();
    
    if (card.type == CardType.magic) {
      // 마법 카드는 별도 처리
      _showMagicCardDialog(card, gameProvider);
    } else {
      // 일반 카드 사용
      gameProvider.playCard(card);
    }
  }

  void _showMagicCardDialog(CardModel card, GameProvider gameProvider) {
    // 마법 카드 사용 확인 다이얼로그를 표시하거나 즉시 사용
    gameProvider.useMagicCard(card);
  }

  Color _getCardBackgroundColor(CardType type) {
    switch (type) {
      case CardType.resource:
        return Colors.green;
      case CardType.unit:
        return Colors.red;
      case CardType.effect:
        return Colors.blue;
      case CardType.magic:
        return Colors.purple;
    }
  }

  Color _getCardBorderColor(CardType type) {
    switch (type) {
      case CardType.resource:
        return Colors.green;
      case CardType.unit:
        return Colors.red;
      case CardType.effect:
        return Colors.blue;
      case CardType.magic:
        return Colors.purple;
    }
  }

  IconData _getCardIcon(CardType type) {
    switch (type) {
      case CardType.resource:
        return Icons.diamond;
      case CardType.unit:
        return Icons.flash_on;
      case CardType.effect:
        return Icons.auto_fix_high;
      case CardType.magic:
        return Icons.star;
    }
  }
}