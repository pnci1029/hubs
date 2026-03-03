import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/card_model.dart';
import '../enums/game_enums.dart';

class GlassmorphicCard extends StatefulWidget {
  final CardModel card;
  final VoidCallback? onTap;
  final bool isPlayable;
  final double width;
  final double height;
  final bool showCost;
  final bool isSelected;
  final bool showGlow;

  const GlassmorphicCard({
    super.key,
    required this.card,
    this.onTap,
    this.isPlayable = true,
    this.width = 140,
    this.height = 180,
    this.showCost = true,
    this.isSelected = false,
    this.showGlow = false,
  });

  @override
  State<GlassmorphicCard> createState() => _GlassmorphicCardState();
}

class _GlassmorphicCardState extends State<GlassmorphicCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _glowController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));
    
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOutSine,
    ));

    if (widget.showGlow) {
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  Color _getCardColor() {
    switch (widget.card.type) {
      case CardType.resource:
        return const Color(0xFF00D4AA); // 네온 시안
      case CardType.unit:
        return const Color(0xFFFF6B35); // 네온 오렌지
      case CardType.effect:
        return const Color(0xFF4ECDC4); // 터쿼이즈
      case CardType.magic:
        return const Color(0xFFB06AB3); // 네온 보라
    }
  }

  Color _getRarityColor() {
    if (widget.card.cost >= 8) return const Color(0xFFFFD700); // 레전더리 골드
    if (widget.card.cost >= 5) return const Color(0xFF9966CC); // 에픽 보라
    if (widget.card.cost >= 3) return const Color(0xFF0099CC); // 레어 블루
    return const Color(0xFF999999); // 커몬 회색
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnimation, _glowAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: widget.isPlayable ? widget.onTap : null,
            onTapDown: (_) {
              if (widget.isPlayable) {
                _hoverController.forward();
              }
            },
            onTapUp: (_) => _hoverController.reverse(),
            onTapCancel: () => _hoverController.reverse(),
            child: Container(
              width: widget.width,
              height: widget.height,
              child: Stack(
                children: [
                  // 글로우 효과
                  if (widget.showGlow || widget.isSelected)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: _getCardColor().withOpacity(0.5 + (_glowAnimation.value * 0.3)),
                            blurRadius: 20 + (_glowAnimation.value * 10),
                            spreadRadius: 2 + (_glowAnimation.value * 3),
                          ),
                        ],
                      ),
                    ),
                  
                  // 메인 카드 백드롭
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _getCardColor().withOpacity(0.25),
                              _getCardColor().withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _getRarityColor().withOpacity(0.6),
                            width: 1.5,
                          ),
                        ),
                        child: _buildCardContent(),
                      ),
                    ),
                  ),
                  
                  // 레어도 테두리 효과
                  if (widget.card.cost >= 5)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _getRarityColor(),
                          width: 2,
                        ),
                      ),
                    ),
                  
                  // 비활성화 오버레이
                  if (!widget.isPlayable)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.lock,
                              color: Colors.grey[300],
                              size: widget.width * 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardContent() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더 (이름 + 코스트)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.card.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: _getCardColor(),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.showCost)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getRarityColor(),
                        _getRarityColor().withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: _getRarityColor().withOpacity(0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Text(
                    widget.card.cost.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // 카드 타입 아이콘
          Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    _getCardColor(),
                    _getCardColor().withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: _getCardColor().withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                _getCardTypeIcon(),
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // 설명
          Expanded(
            child: Text(
              widget.card.description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 10,
                height: 1.3,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // 스탯
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.card.mineral > 0)
                _buildStatChip(
                  Icons.diamond,
                  widget.card.mineral.toString(),
                  Colors.yellow,
                ),
              if (widget.card.attack > 0)
                _buildStatChip(
                  Icons.flash_on,
                  widget.card.attack.toString(),
                  Colors.red,
                ),
              if (widget.card.hp > 0)
                _buildStatChip(
                  Icons.favorite,
                  widget.card.hp.toString(),
                  Colors.green,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 2),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCardTypeIcon() {
    switch (widget.card.type) {
      case CardType.resource:
        return Icons.diamond;
      case CardType.unit:
        return Icons.military_tech;
      case CardType.effect:
        return Icons.auto_awesome;
      case CardType.magic:
        return Icons.auto_fix_high;
    }
  }
}