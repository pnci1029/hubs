import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class MoodSelector extends StatelessWidget {
  final int selectedMood;
  final ValueChanged<int> onMoodChanged;

  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onMoodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘의 기분',
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMoodButton(1, Icons.sentiment_very_dissatisfied, Colors.red, '매우 나쁨'),
            _buildMoodButton(2, Icons.sentiment_dissatisfied, Colors.orange, '나쁨'),
            _buildMoodButton(3, Icons.sentiment_neutral, Colors.yellow, '보통'),
            _buildMoodButton(4, Icons.sentiment_satisfied, Colors.lightGreen, '좋음'),
            _buildMoodButton(5, Icons.sentiment_very_satisfied, Colors.green, '매우 좋음'),
          ],
        ),
      ],
    );
  }

  Widget _buildMoodButton(int mood, IconData icon, Color color, String label) {
    final isSelected = selectedMood == mood;
    
    return GestureDetector(
      onTap: () => onMoodChanged(mood),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? color : Colors.grey[300]!,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected ? color : Colors.grey[400],
              size: 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.caption.copyWith(
              color: isSelected ? color : Colors.grey[500],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}