import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/card_model.dart';
import '../enums/game_enums.dart';

class PremiumCard extends StatefulWidget {
  final CardModel card;
  final VoidCallback? onTap;
  final bool isPlayable;
  final double width;
  final double height;
  final bool showCost;
  final bool isSelected;

  const PremiumCard({
    super.key,
    required this.card,
    this.onTap,
    this.isPlayable = true,
    this.width = 120,
    this.height = 160,
    this.showCost = true,
    this.isSelected = false,
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  Color get _primaryColor {
    switch (widget.card.type) {
      case CardType.resource:
        return const Color(0xFF2ECC71); // 깔끔한 그린
      case CardType.unit:
        return const Color(0xFFE74C3C); // 깔끔한 레드  
      case CardType.effect:
        return const Color(0xFF3498DB); // 깔끔한 블루
      case CardType.magic:
        return const Color(0xFF9B59B6); // 깔끔한 퍼플
    }
  }

  Color get _rarityColor {
    if (widget.card.cost >= 8) return const Color(0xFFFFD700); // 골드
    if (widget.card.cost >= 5) return const Color(0xFFA855F7); // 퍼플  
    if (widget.card.cost >= 3) return const Color(0xFF3B82F6); // 블루
    return const Color(0xFF64748B); // 그레이
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: widget.isPlayable ? widget.onTap : null,
            onTapDown: widget.isPlayable ? (_) => _hoverController.forward() : null,
            onTapUp: (_) => _hoverController.reverse(),
            onTapCancel: () => _hoverController.reverse(),
            child: Container(
              width: widget.width,
              height: widget.height,
              child: Stack(
                children: [
                  // 카드 베이스
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                        if (widget.isSelected || _glowAnimation.value > 0)
                          BoxShadow(
                            color: _rarityColor.withOpacity(0.4),
                            blurRadius: 12 + (_glowAnimation.value * 8),
                            spreadRadius: 2,
                          ),
                      ],
                    ),
                  ),

                  // 카드 헤더 (타입별 색상)
                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          _primaryColor,
                          _primaryColor.withOpacity(0.8),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Icon(
                            _getTypeIcon(),
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.card.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 카드 아트 영역
                  Positioned(
                    top: 32,
                    left: 8,
                    right: 8,
                    child: Container(
                      height: widget.height * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: RadialGradient(
                          colors: [
                            _primaryColor.withOpacity(0.2),
                            _primaryColor.withOpacity(0.05),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _primaryColor.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            _getMainIcon(),
                            color: _primaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 설명 텍스트
                  Positioned(
                    top: widget.height * 0.35 + 40,
                    left: 8,
                    right: 8,
                    child: Container(
                      height: 36,
                      child: Text(
                        widget.card.description,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                          height: 1.2,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  // 스탯 바
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Container(
                      height: 24,
                      child: Center(
                        child: Wrap(
                          spacing: 4,
                          alignment: WrapAlignment.center,
                          children: [
                            if (widget.card.mineral > 0)
                              _buildStatChip(
                                '⚡',
                                widget.card.mineral.toString(),
                                const Color(0xFFF39C12),
                              ),
                            if (widget.card.attack > 0)
                              _buildStatChip(
                                '⚔️',
                                widget.card.attack.toString(),
                                const Color(0xFFE74C3C),
                              ),
                            if (widget.card.hp > 0)
                              _buildStatChip(
                                '❤️',
                                widget.card.hp.toString(),
                                const Color(0xFF27AE60),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 코스트 뱃지
                  if (widget.showCost && widget.card.cost > 0)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: _rarityColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _rarityColor.withOpacity(0.3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${widget.card.cost}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                  // 비활성화 오버레이
                  if (!widget.isPlayable)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                          size: 32,
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

  Widget _buildStatChip(String emoji, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 8)),
          const SizedBox(width: 2),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon() {
    switch (widget.card.type) {
      case CardType.resource:
        return Icons.eco;
      case CardType.unit:
        return Icons.shield;
      case CardType.effect:
        return Icons.auto_awesome;
      case CardType.magic:
        return Icons.auto_fix_high;
    }
  }

  IconData _getMainIcon() {
    // 카드별 고유 아이콘 (나중에 커스텀 아트워크로 교체)
    switch (widget.card.name) {
      case "SCV":
        return Icons.construction;
      case "마린":
        return Icons.military_tech;
      case "드론":
        return Icons.precision_manufacturing;
      case "히드라":
        return Icons.bug_report;
      case "프로브":
        return Icons.psychology;
      case "드라군":
        return Icons.smart_toy;
      case "잉여":
        return Icons.help_outline;
      case "보급고":
        return Icons.home_work;
      case "풍선":
        return Icons.bubble_chart;
      case "공업 단지":
        return Icons.factory;
      default:
        return Icons.stars;
    }
  }
}