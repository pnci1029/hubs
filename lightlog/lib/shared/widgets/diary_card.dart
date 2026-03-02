import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../models/diary_entry.dart';

class DiaryCard extends StatelessWidget {
  final DiaryEntry diary;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final String? highlightQuery;

  const DiaryCard({
    super.key,
    required this.diary,
    this.onTap,
    this.onDelete,
    this.highlightQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        child: Padding(
          padding: AppTheme.paddingMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with date and mood
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatDate(diary.createdAt),
                          style: AppTheme.bodySmall.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (diary.title.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          _buildHighlightedText(
                            diary.title,
                            style: AppTheme.heading3,
                            highlight: highlightQuery,
                          ),
                        ],
                      ],
                    ),
                  ),
                  _buildMoodIndicator(diary.mood),
                  if (onDelete != null) ...[
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'delete') {
                          onDelete!();
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline, size: 18),
                              SizedBox(width: 8),
                              Text('삭제'),
                            ],
                          ),
                        ),
                      ],
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                    ),
                  ],
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Content preview
              _buildHighlightedText(
                _getContentPreview(diary.content),
                style: AppTheme.bodyMedium.copyWith(
                  height: 1.4,
                ),
                highlight: highlightQuery,
              ),
              
              // Tags
              if (diary.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: diary.tags.take(3).map((tag) => _buildTag(tag)).toList(),
                ),
              ],
              
              // Footer with updated time and AI indicator
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    '수정됨 ${_formatDateTime(diary.updatedAt)}',
                    style: AppTheme.caption,
                  ),
                  const Spacer(),
                  if (diary.aiAnalysis != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.psychology_outlined,
                            size: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'AI',
                            style: AppTheme.caption.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodIndicator(int mood) {
    final moods = [
      {'icon': Icons.sentiment_very_dissatisfied, 'color': Colors.red},
      {'icon': Icons.sentiment_dissatisfied, 'color': Colors.orange},
      {'icon': Icons.sentiment_neutral, 'color': Colors.yellow},
      {'icon': Icons.sentiment_satisfied, 'color': Colors.lightGreen},
      {'icon': Icons.sentiment_very_satisfied, 'color': Colors.green},
    ];

    final moodData = moods[mood - 1];
    
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: (moodData['color'] as Color).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        moodData['icon'] as IconData,
        size: 18,
        color: moodData['color'] as Color,
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '#$tag',
        style: AppTheme.caption.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildHighlightedText(
    String text, {
    required TextStyle style,
    String? highlight,
  }) {
    if (highlight == null || highlight.isEmpty) {
      return Text(text, style: style);
    }

    final String query = highlight.toLowerCase();
    final String lowerText = text.toLowerCase();
    final List<TextSpan> spans = [];
    
    int start = 0;
    int index = lowerText.indexOf(query);
    
    while (index != -1) {
      // Add text before match
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: style,
        ));
      }
      
      // Add highlighted match
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: style.copyWith(
          backgroundColor: Colors.yellow.withOpacity(0.3),
          fontWeight: FontWeight.w600,
        ),
      ));
      
      start = index + query.length;
      index = lowerText.indexOf(query, start);
    }
    
    // Add remaining text
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: style,
      ));
    }
    
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final diaryDate = DateTime(date.year, date.month, date.day);
    
    if (diaryDate == today) {
      return '오늘';
    } else if (diaryDate == yesterday) {
      return '어제';
    } else {
      return DateFormat('M월 d일').format(date);
    }
  }

  String _formatDateTime(DateTime date) {
    return DateFormat('M/d HH:mm').format(date);
  }

  String _getContentPreview(String content) {
    const int maxLength = 120;
    if (content.length <= maxLength) {
      return content;
    }
    
    return '${content.substring(0, maxLength)}...';
  }
}