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

class ShopArea extends StatefulWidget {
  const ShopArea({super.key});

  @override
  State<ShopArea> createState() => _ShopAreaState();
}

class _ShopAreaState extends State<ShopArea> with TickerProviderStateMixin {
  late AnimationController _purchaseAnimationController;
  late Animation<double> _purchaseAnimation;
  String? _lastPurchasedCard;
  
  @override
  void initState() {
    super.initState();
    _purchaseAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _purchaseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _purchaseAnimationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _purchaseAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  PremiumTheme.surfaceDark.withOpacity(0.3),
                  PremiumTheme.backgroundMid.withOpacity(0.2),
                  Colors.black.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: PremiumTheme.primaryNeon.withOpacity(0.3),
                width: 1,
              ),
            ),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  PremiumTheme.primaryNeon.withOpacity(0.2),
                  PremiumTheme.secondaryNeon.withOpacity(0.1),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.store, color: PremiumTheme.primaryNeon, size: 28),
                const SizedBox(width: 8),
                Text(
                  "상점",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Consumer<GameProvider>(
                  builder: (context, gameProvider, child) {
                    return AnimatedBuilder(
                      animation: _purchaseAnimation,
                      builder: (context, child) {
                        return Row(
                          children: [
                            Icon(
                              Icons.diamond, 
                              color: Colors.yellow, 
                              size: 16 + (_purchaseAnimation.value * 4),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "마나: ${gameProvider.currentMana}",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14 + (_purchaseAnimation.value * 2),
                                fontWeight: _purchaseAnimation.value > 0.5 
                                    ? FontWeight.bold 
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          
          // 상점 카드들
          Expanded(
            child: Consumer<GameProvider>(
              builder: (context, gameProvider, child) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: gameProvider.shopCards.length,
                    itemBuilder: (context, index) {
                      final card = gameProvider.shopCards[index];
                      final canAfford = gameProvider.currentMana >= 1;
                      
                      return AnimatedBuilder(
                        animation: _purchaseAnimation,
                        builder: (context, child) {
                          final isPurchased = _lastPurchasedCard == card.id && 
                                            _purchaseAnimation.value > 0;
                          
                          return Transform.scale(
                            scale: isPurchased 
                                ? 1.0 - _purchaseAnimation.value
                                : 1.0,
                            child: Opacity(
                              opacity: isPurchased 
                                  ? 1.0 - _purchaseAnimation.value
                                  : 1.0,
                              child: IllustratedCard(
                                card: card,
                                onTap: canAfford ? () {
                                  _handlePurchase(gameProvider, card);
                                } : () {
                                  SoundService().playError();
                                  _showInsufficientManaFeedback();
                                },
                                isPlayable: canAfford,
                                width: 140,
                                height: 180,
                                showCost: true,
                              ),
                            ),
                          );
                        },
                      ).animate().fadeIn(
                        duration: Duration(milliseconds: 500 + (index * 100)),
                      ).scale(
                        begin: const Offset(0.8, 0.8),
                        duration: Duration(milliseconds: 500 + (index * 100)),
                        curve: Curves.elasticOut,
                      );
                    },
                  ),
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

  void _handlePurchase(GameProvider gameProvider, CardModel card) {
    setState(() {
      _lastPurchasedCard = card.id;
    });
    
    // 마나 소모 애니메이션 시작
    _purchaseAnimationController.forward().then((_) {
      _purchaseAnimationController.reset();
      setState(() {
        _lastPurchasedCard = null;
      });
    });
    
    // 사운드 효과
    SoundService().playCardBuy();
    
    // 실제 구매 처리
    gameProvider.buyCard(card);
    
    // 성공 피드백 표시
    _showPurchaseSuccessFeedback(card);
  }

  void _showPurchaseSuccessFeedback(CardModel card) {
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${card.name} 구매 완료!',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '덱에 추가됨',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  void _showInsufficientManaFeedback() {
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '마나가 부족합니다!',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  Widget _buildShopCard(BuildContext context, CardModel card, GameProvider gameProvider) {
    final canAfford = gameProvider.currentMana >= 1;
    
    return GestureDetector(
      onTap: canAfford ? () => gameProvider.buyCard(card) : null,
      child: Container(
        decoration: BoxDecoration(
          color: _getCardBackgroundColor(card.type).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: canAfford 
                ? _getCardBorderColor(card.type)
                : Colors.grey.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            // 카드 내용
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 카드 타입 아이콘과 이름
                  Row(
                    children: [
                      Icon(
                        _getCardIcon(card.type),
                        color: _getCardBorderColor(card.type),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          card.name,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // 카드 효과
                  Expanded(
                    child: Text(
                      card.description,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // 카드 능력치
                  Row(
                    children: [
                      if (card.mineral > 0) ...[
                        const Icon(Icons.diamond, color: Colors.yellow, size: 14),
                        Text(
                          " ${card.mineral}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      if (card.attack > 0) ...[
                        const Icon(Icons.flash_on, color: Colors.red, size: 14),
                        Text(
                          " ${card.attack}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            
            // 비용 표시
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: canAfford ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.diamond, color: Colors.white, size: 12),
                    const SizedBox(width: 2),
                    Text(
                      "1",  // 모든 카드 구매 비용은 마나 1
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // 구매 불가능 오버레이
            if (!canAfford)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.lock,
                    color: Colors.grey,
                    size: 24,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
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