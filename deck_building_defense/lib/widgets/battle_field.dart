import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import '../models/enemy_model.dart';
import '../enums/game_enums.dart';

class BattleField extends StatelessWidget {
  const BattleField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return Column(
            children: [
              // 헤더
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.security, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      "전투 필드",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    if (gameProvider.enemies.isNotEmpty)
                      Text(
                        "적: ${gameProvider.enemies.length}마리",
                        style: const TextStyle(color: Colors.white70),
                      ),
                  ],
                ),
              ),
              
              // 적 표시 영역
              Expanded(
                child: gameProvider.enemies.isEmpty
                    ? _buildEmptyField(gameProvider.isRoundActive)
                    : _buildEnemyGrid(gameProvider.enemies),
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
            isRoundActive ? "모든 적을 물리쳤습니다!" : "라운드를 시작하세요",
            style: TextStyle(
              fontSize: 18,
              color: isRoundActive ? Colors.green : Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate().slideY(
      begin: -0.5,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
    ).then().shake(
      hz: 2,
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget _buildEnemyGrid(List<EnemyModel> enemies) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: enemies.length,
        itemBuilder: (context, index) {
          return _buildEnemyCard(enemies[index], index);
        },
      ),
    );
  }

  Widget _buildEnemyCard(EnemyModel enemy, int index) {
    return Container(
      decoration: BoxDecoration(
        color: _getEnemyColor(enemy.type).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getEnemyColor(enemy.type),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 적 아이콘
            Icon(
              _getEnemyIcon(enemy.type),
              color: _getEnemyColor(enemy.type),
              size: 24,
            ),
            
            const SizedBox(height: 4),
            
            // 적 이름
            Text(
              _getEnemyDisplayName(enemy.type),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 4),
            
            // HP 바
            _buildHealthBar(enemy),
            
            const SizedBox(height: 2),
            
            // 상태 정보
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (enemy.defense > 0) ...[
                  Icon(Icons.shield, size: 12, color: Colors.blue),
                  Text(
                    "${enemy.defense}",
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
                if (enemy.currentShield > 0) ...[
                  const SizedBox(width: 4),
                  Icon(Icons.security, size: 12, color: Colors.cyan),
                  Text(
                    "${enemy.currentShield}",
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthBar(EnemyModel enemy) {
    return Column(
      children: [
        // HP 바
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.3),
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
        
        // 쉴드 바 (있는 경우)
        if (enemy.shield > 0) ...[
          const SizedBox(height: 1),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: Colors.cyan.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: enemy.shieldPercentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ],
    );
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

  String _getEnemyDisplayName(EnemyType type) {
    switch (type) {
      case EnemyType.mass:
        return "물량형";
      case EnemyType.armored:
        return "방어형";
      case EnemyType.shielded:
        return "쉴드형";
    }
  }
}