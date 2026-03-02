import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return Row(
            children: [
              // 라운드 정보
              _buildStatusItem(
                icon: Icons.timeline,
                label: "라운드",
                value: "${gameProvider.currentRound}/30",
                color: gameProvider.isBossRound ? Colors.red : Colors.blue,
              ),
              
              const SizedBox(width: 24),
              
              // 마나 정보
              _buildStatusItem(
                icon: Icons.battery_charging_full,
                label: "마나",
                value: gameProvider.currentMana.toString(),
                color: Colors.cyan,
              ),
              
              const SizedBox(width: 24),
              
              // HP 정보
              _buildStatusItem(
                icon: Icons.favorite,
                label: "HP",
                value: gameProvider.playerHP.toString(),
                color: gameProvider.playerHP > 50 ? Colors.green : Colors.red,
              ),
              
              const SizedBox(width: 24),
              
              // 공업 레벨
              _buildStatusItem(
                icon: Icons.upgrade,
                label: "공업",
                value: "+${gameProvider.upgrade}",
                color: Colors.orange,
              ),
              
              const Spacer(),
              
              // 타이머 및 라운드 시작 버튼
              if (gameProvider.isRoundActive) ...[
                Icon(
                  Icons.timer,
                  color: gameProvider.remainingTime <= 10 ? Colors.red : Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  "${gameProvider.remainingTime}초",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: gameProvider.remainingTime <= 10 ? Colors.red : Colors.white,
                  ),
                ),
              ] else ...[
                ElevatedButton.icon(
                  onPressed: () {
                    if (gameProvider.isBossRound) {
                      SoundService().playBossWarning();
                    } else {
                      SoundService().playRoundStart();
                    }
                    gameProvider.startRound();
                  },
                  icon: Icon(
                    gameProvider.isBossRound ? Icons.shield : Icons.play_arrow,
                  ),
                  label: Text(
                    gameProvider.isBossRound ? "보스 라운드 시작" : "라운드 시작",
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gameProvider.isBossRound ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ).animate(target: gameProvider.isBossRound ? 1 : 0)
                  .shake(hz: 4, curve: Curves.easeInOut)
                  .then()
                  .shimmer(color: Colors.red.withValues(alpha: 0.5)),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}