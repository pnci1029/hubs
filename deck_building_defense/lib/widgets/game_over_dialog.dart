import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GameOverDialog extends StatelessWidget {
  final bool isVictory;
  final VoidCallback onRestart;

  const GameOverDialog({
    super.key,
    required this.isVictory,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isVictory ? Colors.green : Colors.red,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: (isVictory ? Colors.green : Colors.red).withValues(alpha: 0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 결과 아이콘
            Icon(
              isVictory ? Icons.emoji_events : Icons.sentiment_very_dissatisfied,
              size: 80,
              color: isVictory ? Colors.yellow : Colors.red,
            ).animate()
              .scale(duration: const Duration(milliseconds: 500))
              .then()
              .shake(hz: 4, curve: Curves.easeInOut),
            
            const SizedBox(height: 16),
            
            // 결과 텍스트
            Text(
              isVictory ? "승리!" : "패배!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isVictory ? Colors.green : Colors.red,
              ),
            ).animate()
              .fadeIn(delay: const Duration(milliseconds: 300))
              .slideY(begin: 0.3),
            
            const SizedBox(height: 8),
            
            Text(
              isVictory
                  ? "모든 라운드를 클리어했습니다!"
                  : "다시 도전해보세요!",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ).animate()
              .fadeIn(delay: const Duration(milliseconds: 500)),
            
            const SizedBox(height: 24),
            
            // 버튼들
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: onRestart,
                  icon: const Icon(Icons.refresh),
                  label: const Text("다시 시작"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ).animate()
                  .fadeIn(delay: const Duration(milliseconds: 700))
                  .slideX(begin: -0.3),
                
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  label: const Text("닫기"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ).animate()
                  .fadeIn(delay: const Duration(milliseconds: 700))
                  .slideX(begin: 0.3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}