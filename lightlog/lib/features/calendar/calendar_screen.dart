import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/models/diary_entry.dart';
import '../../shared/providers/diary_provider.dart';
import '../../shared/widgets/diary_card.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late final ValueNotifier<DateTime> _selectedDay;
  late final ValueNotifier<DateTime> _focusedDay;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  
  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _selectedDay = ValueNotifier(today);
    _focusedDay = ValueNotifier(today);
  }

  @override
  void dispose() {
    _selectedDay.dispose();
    _focusedDay.dispose();
    super.dispose();
  }

  List<DiaryEntry> _getEventsForDay(List<DiaryEntry> diaries, DateTime day) {
    return diaries.where((diary) => isSameDay(diary.createdAt, day)).toList();
  }

  bool _hasDiaryOnDay(List<DiaryEntry> diaries, DateTime day) {
    return diaries.any((diary) => isSameDay(diary.createdAt, day));
  }

  @override
  Widget build(BuildContext context) {
    final diariesAsync = ref.watch(diaryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('일기 캘린더'),
        actions: [
          IconButton(
            onPressed: () {
              _selectedDay.value = DateTime.now();
              _focusedDay.value = DateTime.now();
            },
            icon: const Icon(Icons.today),
            tooltip: '오늘로',
          ),
        ],
      ),
      body: diariesAsync.when(
        data: (diaries) => Column(
          children: [
            // Calendar widget
            Card(
              margin: AppTheme.paddingMedium,
              child: ValueListenableBuilder<DateTime>(
                valueListenable: _selectedDay,
                builder: (context, selectedDay, _) {
                  return ValueListenableBuilder<DateTime>(
                    valueListenable: _focusedDay,
                    builder: (context, focusedDay, _) {
                      return TableCalendar<DiaryEntry>(
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.now(),
                        focusedDay: focusedDay,
                        calendarFormat: _calendarFormat,
                        eventLoader: (day) => _getEventsForDay(diaries, day),
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        
                        // Calendar style
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          weekendTextStyle: AppTheme.bodyMedium.copyWith(
                            color: Colors.red[400],
                          ),
                          holidayTextStyle: AppTheme.bodyMedium.copyWith(
                            color: Colors.red[400],
                          ),
                          
                          // Selected day style
                          selectedDecoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          selectedTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          
                          // Today style
                          todayDecoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          todayTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          
                          // Marker style for days with diaries
                          markersMaxCount: 1,
                          markerDecoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                          markerSize: 6,
                        ),
                        
                        // Header style
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: AppTheme.heading3,
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        
                        // Day selection
                        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay.value, selectedDay)) {
                            _selectedDay.value = selectedDay;
                            _focusedDay.value = focusedDay;
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay.value = focusedDay;
                        },
                        
                        // Custom day builder to show diary indicators
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                            final hasDiary = _hasDiaryOnDay(diaries, day);
                            if (!hasDiary) return null;
                            
                            return Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '${day.day}',
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Selected day info and diaries
            Expanded(
              child: ValueListenableBuilder<DateTime>(
                valueListenable: _selectedDay,
                builder: (context, selectedDay, _) {
                  final dayDiaries = _getEventsForDay(diaries, selectedDay);
                  
                  return SingleChildScrollView(
                    padding: AppTheme.paddingMedium,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Selected day header
                        Row(
                          children: [
                            Text(
                              DateFormat('M월 d일 EEEE', 'ko_KR').format(selectedDay),
                              style: AppTheme.heading3,
                            ),
                            const Spacer(),
                            if (dayDiaries.isEmpty)
                              FilledButton.icon(
                                onPressed: () async {
                                  final result = await context.push('/write');
                                  if (result == true) {
                                    ref.invalidate(diaryListProvider);
                                  }
                                },
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('일기 쓰기'),
                              ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Diaries for selected day
                        if (dayDiaries.isEmpty)
                          _buildEmptyDay(selectedDay)
                        else
                          ...dayDiaries.map((diary) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: DiaryCard(
                              diary: diary,
                              onTap: () async {
                                final result = await context.push('/write?id=${diary.id}');
                                if (result == true) {
                                  ref.invalidate(diaryListProvider);
                                }
                              },
                              onDelete: () => _showDeleteDialog(diary),
                            ),
                          )),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[300],
              ),
              const SizedBox(height: 16),
              Text(
                '오류가 발생했습니다',
                style: AppTheme.heading3,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: AppTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => ref.invalidate(diaryListProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyDay(DateTime day) {
    final isToday = isSameDay(day, DateTime.now());
    final isPast = day.isBefore(DateTime.now());
    
    return Container(
      width: double.infinity,
      padding: AppTheme.paddingLarge,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[200]!,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isToday 
              ? Icons.edit_calendar_outlined
              : Icons.event_note_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            isToday 
              ? '오늘의 일기를 작성해보세요'
              : isPast
                ? '이 날에는 일기를 쓰지 않았어요'
                : '미래의 일기는 작성할 수 없어요',
            style: AppTheme.bodyLarge.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          if (isToday || isPast) ...[
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () async {
                final result = await context.push('/write');
                if (result == true) {
                  ref.invalidate(diaryListProvider);
                }
              },
              icon: const Icon(Icons.edit_outlined),
              label: Text(isToday ? '오늘 일기 쓰기' : '일기 쓰기'),
            ),
          ],
        ],
      ),
    );
  }

  void _showDeleteDialog(DiaryEntry diary) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('일기 삭제'),
        content: const Text('이 일기를 삭제하시겠습니까?\n삭제된 일기는 복구할 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await ref.read(diaryListProvider.notifier).deleteDiary(diary.id);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('일기가 삭제되었습니다')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('삭제 실패: $e')),
                  );
                }
              }
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}