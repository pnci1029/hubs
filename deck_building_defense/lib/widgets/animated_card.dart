import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/card_model.dart';
import '../enums/game_enums.dart';
import '../utils/unit_icons.dart';
import '../widgets/unit_avatar.dart';

class AnimatedCard extends StatefulWidget {
  final CardModel card;
  final VoidCallback? onTap;
  final bool isPlayable;
  final bool isSelected;
  final double width;
  final double height;
  final bool showCost;

  const AnimatedCard({
    super.key,
    required this.card,
    this.onTap,
    this.isPlayable = true,
    this.isSelected = false,
    this.width = 80,
    this.height = 110,
    this.showCost = true,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.isPlayable ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.isPlayable ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: widget.isPlayable ? () => setState(() => _isPressed = false) : null,
      onTap: widget.isPlayable ? widget.onTap : null,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          height: widget.height,
          transform: Matrix4.identity()
            ..scale(
              _isPressed ? 0.95 : (_isHovered || widget.isSelected ? 1.05 : 1.0),
            ),
          child: Container(
            decoration: BoxDecoration(
              color: _getCardBackgroundColor(widget.card.type).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: widget.isPlayable
                    ? (widget.isSelected 
                        ? Colors.yellow 
                        : _getCardBorderColor(widget.card.type))
                    : Colors.grey.withValues(alpha: 0.3),
                width: widget.isSelected ? 3 : 2,
              ),
              boxShadow: _isHovered || widget.isSelected
                  ? [
                      BoxShadow(
                        color: _getCardBorderColor(widget.card.type).withValues(alpha: 0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
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
                      Row(
                        children: [
                          Icon(
                            widget.card.type == CardType.unit
                                ? UnitIcons.getUnitIcon(widget.card.name)
                                : _getCardIcon(widget.card.type),
                            color: widget.card.type == CardType.unit
                                ? UnitIcons.getUnitColor(widget.card.name)
                                : _getCardBorderColor(widget.card.type),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          if (widget.card.type == CardType.unit)
                            Text(
                              UnitIcons.getUnitType(widget.card.name),
                              style: TextStyle(
                                fontSize: 8,
                                color: UnitIcons.getUnitColor(widget.card.name),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (widget.card.ignoreDefense)
                            const Icon(
                              Icons.gps_fixed,
                              color: Colors.orange,
                              size: 12,
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // 카드 이름
                      Text(
                        widget.card.name,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // 카드 아바타 (모든 카드 타입)
                      Expanded(
                        child: Center(
                          child: UnitAvatar(
                            unitName: widget.card.name,
                            cardType: widget.card.type.name,
                            size: widget.width * 0.6,
                          ),
                        ),
                      ),
                      
                      // 카드 능력치
                      if (widget.card.mineral > 0) ...[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.diamond, color: Colors.yellow, size: 12),
                            const SizedBox(width: 2),
                            Text(
                              "${widget.card.mineral}",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                      
                      if (widget.card.attack > 0) ...[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.flash_on, color: Colors.red, size: 12),
                            const SizedBox(width: 2),
                            Text(
                              "${widget.card.attack}",
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
                if (widget.showCost && widget.card.cost > 0)
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
                        "${widget.card.cost}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                
                // 사용 불가능 오버레이
                if (!widget.isPlayable)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
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
        ),
      ),
    )
        .animate(target: widget.isSelected ? 1 : 0)
        .shimmer(
          duration: const Duration(milliseconds: 1500),
          color: Colors.yellow.withValues(alpha: 0.3),
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