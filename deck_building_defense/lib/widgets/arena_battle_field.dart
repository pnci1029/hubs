import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import '../models/enemy_model.dart';
import '../models/card_model.dart';
import '../enums/game_enums.dart';
import '../utils/unit_icons.dart';
import '../widgets/unit_avatar.dart';

class ArenaBattleField extends StatefulWidget {
  const ArenaBattleField({super.key});

  @override
  State<ArenaBattleField> createState() => _ArenaBattleFieldState();
}

class _ArenaBattleFieldState extends State<ArenaBattleField>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.stadium, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      "전투 아레나",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    if (gameProvider.enemies.isNotEmpty || gameProvider.fieldUnits.isNotEmpty)
                      Text(
                        "적: ${gameProvider.enemies.length} | 아군: ${gameProvider.fieldUnits.length}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                  ],
                ),
              ),
              
              Expanded(
                child: gameProvider.enemies.isEmpty && gameProvider.fieldUnits.isEmpty
                    ? _buildEmptyField(gameProvider.isRoundActive)
                    : _buildArena(gameProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyField(bool isRoundActive) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isRoundActive ? Icons.check_circle : Icons.shield_outlined,
            size: 64,
            color: isRoundActive ? Colors.green : Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            isRoundActive ? "모든 적을 물리쳤습니다!" : "유닛을 배치하고 라운드를 시작하세요",
            style: TextStyle(
              fontSize: 18,
              color: isRoundActive ? Colors.green : Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArena(GameProvider gameProvider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final centerX = constraints.maxWidth / 2;
          final centerY = constraints.maxHeight / 2;
          final radius = math.min(centerX, centerY) * 0.6;
          final innerRadius = radius * 0.4;

          return Stack(
            children: [
              AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Stack(
                    children: [
                      ...gameProvider.enemies.asMap().entries.map((entry) {
                        final index = entry.key;
                        final enemy = entry.value;
                        final angle = (index * 2 * math.pi / gameProvider.enemies.length) +
                            (_rotationController.value * 2 * math.pi);
                        final x = centerX + radius * math.cos(angle) - 30;
                        final y = centerY + radius * math.sin(angle) - 30;

                        return Positioned(
                          left: x,
                          top: y,
                          child: _buildEnemyUnit(enemy),
                        );
                      }),

                      ...gameProvider.fieldUnits.asMap().entries.map((entry) {
                        final index = entry.key;
                        final unit = entry.value;
                        final angle = index * 2 * math.pi / math.max(1, gameProvider.fieldUnits.length);
                        final x = centerX + innerRadius * math.cos(angle) - 25;
                        final y = centerY + innerRadius * math.sin(angle) - 25;

                        return Positioned(
                          left: x,
                          top: y,
                          child: _buildFriendlyUnit(unit),
                        );
                      }),
                    ],
                  );
                },
              ),

              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: const Icon(
                    Icons.home,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEnemyUnit(EnemyModel enemy) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: _getEnemyColor(enemy.type).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getEnemyColor(enemy.type),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getEnemyIcon(enemy.type),
            color: _getEnemyColor(enemy.type),
            size: 20,
          ),
          const SizedBox(height: 2),
          Container(
            height: 3,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: enemy.hpPercentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          if (enemy.currentShield > 0) ...[
            const SizedBox(height: 1),
            Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.cyan.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(1),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: enemy.shieldPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 300))
      .scale(begin: const Offset(0.5, 0.5));
  }

  Widget _buildFriendlyUnit(CardModel unit) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: UnitIcons.getUnitColor(unit.name).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: unit.isDead ? Colors.red : UnitIcons.getUnitColor(unit.name),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 유닛 아바타
            UnitAvatar(
              unitName: unit.name,
              cardType: "unit",
              size: 25,
              isDead: unit.isDead,
            ),
            const SizedBox(height: 2),
            Container(
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: UnitIcons.getUnitColor(unit.name).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: unit.hpPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: UnitIcons.getUnitColor(unit.name),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            Text(
              "${unit.attack}",
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(duration: const Duration(milliseconds: 300))
      .scale(begin: const Offset(0.8, 0.8));
  }

  Color _getEnemyColor(EnemyType type) {
    switch (type) {
      case EnemyType.mass:
        return Colors.orange;
      case EnemyType.armored:
        return Colors.blue;
      case EnemyType.shielded:
        return Colors.purple;
    }
  }

  IconData _getEnemyIcon(EnemyType type) {
    switch (type) {
      case EnemyType.mass:
        return Icons.groups;
      case EnemyType.armored:
        return Icons.shield;
      case EnemyType.shielded:
        return Icons.security;
    }
  }
}