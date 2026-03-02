import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/models/diary_entry.dart';
import '../../shared/providers/diary_provider.dart';
import '../../shared/widgets/diary_card.dart';
import '../../shared/widgets/stats_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        ref.read(searchProvider.notifier).clear();
      }
    });
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      ref.read(searchProvider.notifier).clear();
    } else {
      ref.read(searchProvider.notifier).search(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final diariesAsync = ref.watch(diaryListProvider);
    final searchResultsAsync = ref.watch(searchProvider);
    final statsAsync = ref.watch(diaryStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching 
          ? TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: '일기 검색...',
                border: InputBorder.none,
              ),
              onChanged: _onSearchChanged,
              autofocus: true,
            )
          : const Text('내 일기'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(diaryListProvider);
          ref.invalidate(diaryStatsProvider);
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Statistics section
            if (!_isSearching) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppTheme.paddingMedium,
                  child: statsAsync.when(
                    data: (stats) => StatsCard(stats: stats),
                    loading: () => const _StatsLoadingCard(),
                    error: (error, stack) => const SizedBox(),
                  ),
                ),
              ),
              
              // Section header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      Text(
                        '최근 일기',
                        style: AppTheme.heading3,
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () => context.push('/calendar'),
                        icon: const Icon(Icons.calendar_month),
                        label: const Text('캘린더'),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Diary list
            _isSearching 
              ? _buildSearchResults(searchResultsAsync)
              : _buildDiaryList(diariesAsync),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await context.push('/write');
          if (result == true) {
            ref.invalidate(diaryListProvider);
            ref.invalidate(diaryStatsProvider);
          }
        },
        icon: const Icon(Icons.edit_outlined),
        label: const Text('일기 쓰기'),
      ),
    );
  }

  Widget _buildDiaryList(AsyncValue<List<DiaryEntry>> diariesAsync) {
    return diariesAsync.when(
      data: (diaries) {
        if (diaries.isEmpty) {
          return const SliverFillRemaining(
            child: _EmptyState(),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final diary = diaries[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
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
              );
            },
            childCount: diaries.length,
          ),
        );
      },
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => SliverFillRemaining(
        child: _ErrorState(
          error: error.toString(),
          onRetry: () => ref.invalidate(diaryListProvider),
        ),
      ),
    );
  }

  Widget _buildSearchResults(AsyncValue<List<DiaryEntry>> searchResultsAsync) {
    return searchResultsAsync.when(
      data: (results) {
        if (_searchController.text.trim().isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Text(
                  '검색어를 입력해주세요',
                  style: AppTheme.bodyMedium,
                ),
              ),
            ),
          );
        }

        if (results.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '검색 결과가 없습니다',
                      style: AppTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '다른 키워드로 검색해보세요',
                      style: AppTheme.bodyMedium.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final diary = results[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: DiaryCard(
                  diary: diary,
                  onTap: () async {
                    final result = await context.push('/write?id=${diary.id}');
                    if (result == true) {
                      ref.invalidate(diaryListProvider);
                      _onSearchChanged(_searchController.text);
                    }
                  },
                  onDelete: () => _showDeleteDialog(diary),
                  highlightQuery: _searchController.text,
                ),
              );
            },
            childCount: results.length,
          ),
        );
      },
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => SliverFillRemaining(
        child: _ErrorState(
          error: error.toString(),
          onRetry: () => _onSearchChanged(_searchController.text),
        ),
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

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_stories_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            '아직 작성된 일기가 없어요',
            style: AppTheme.heading3.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '첫 번째 일기를 작성해보세요!',
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: () => context.push('/write'),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('일기 쓰기'),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[300],
          ),
          const SizedBox(height: 24),
          Text(
            '오류가 발생했습니다',
            style: AppTheme.heading3,
          ),
          const SizedBox(height: 12),
          Text(
            error,
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }
}

class _StatsLoadingCard extends StatelessWidget {
  const _StatsLoadingCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppTheme.paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '일기 통계',
              style: AppTheme.heading3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}