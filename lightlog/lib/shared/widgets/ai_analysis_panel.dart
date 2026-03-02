import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../providers/diary_provider.dart';

class AIAnalysisPanel extends ConsumerStatefulWidget {
  final String content;
  final String? diaryId;

  const AIAnalysisPanel({
    super.key,
    required this.content,
    this.diaryId,
  });

  @override
  ConsumerState<AIAnalysisPanel> createState() => _AIAnalysisPanelState();
}

class _AIAnalysisPanelState extends ConsumerState<AIAnalysisPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, String?> _analyses = {};
  final Map<String, bool> _loading = {};

  final List<AnalysisMode> _modes = [
    AnalysisMode('counselor', '상담사', Icons.psychology_outlined, Colors.blue),
    AnalysisMode('bestfriend', '친구', Icons.favorite_outline, Colors.pink),
    AnalysisMode('motivator', '동기부여', Icons.rocket_launch_outlined, Colors.orange),
    AnalysisMode('summary', '요약', Icons.summarize_outlined, Colors.green),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _modes.length, vsync: this);
    _loadInitialAnalysis();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadInitialAnalysis() {
    // Load counselor analysis by default
    _getAnalysis('counselor');
  }

  Future<void> _getAnalysis(String mode) async {
    if (_analyses.containsKey(mode) && _analyses[mode] != null) {
      return; // Already loaded
    }

    setState(() {
      _loading[mode] = true;
    });

    try {
      final repository = ref.read(diaryRepositoryProvider);
      final analysis = await repository.getAIAnalysis(
        diaryId: widget.diaryId ?? 'temp',
        content: widget.content,
        mode: mode,
      );

      setState(() {
        _analyses[mode] = analysis;
        _loading[mode] = false;
      });
    } catch (e) {
      setState(() {
        _analyses[mode] = '분석을 가져오는데 실패했습니다: $e';
        _loading[mode] = false;
      });
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('클립보드에 복사되었습니다'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.psychology,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'AI 분석',
                  style: AppTheme.heading3,
                ),
                const Spacer(),
                Text(
                  '${widget.content.length}자',
                  style: AppTheme.caption,
                ),
              ],
            ),
          ),

          // Tabs
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: Theme.of(context).colorScheme.primary,
            onTap: (index) {
              final mode = _modes[index].id;
              _getAnalysis(mode);
            },
            tabs: _modes.map((mode) => Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(mode.icon, size: 16),
                  const SizedBox(width: 6),
                  Text(mode.name),
                ],
              ),
            )).toList(),
          ),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _modes.map((mode) => _buildAnalysisContent(mode)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisContent(AnalysisMode mode) {
    final isLoading = _loading[mode.id] ?? false;
    final analysis = _analyses[mode.id];

    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('AI가 분석 중입니다...'),
          ],
        ),
      );
    }

    if (analysis == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              mode.icon,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '${mode.name} 모드로 분석해보세요',
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _getAnalysis(mode.id),
              icon: Icon(mode.icon, size: 18),
              label: const Text('분석 시작'),
              style: FilledButton.styleFrom(
                backgroundColor: mode.color,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Analysis mode info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: mode.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: mode.color.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(mode.icon, color: mode.color, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${mode.name} 관점',
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: mode.color,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => _copyToClipboard(analysis),
                  icon: const Icon(Icons.copy, size: 18),
                  tooltip: '복사',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Analysis content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[200]!,
              ),
            ),
            child: Text(
              analysis,
              style: AppTheme.bodyMedium.copyWith(
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _analyses[mode.id] = null;
                    });
                    _getAnalysis(mode.id);
                  },
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('새로 분석'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _copyToClipboard(analysis),
                  icon: const Icon(Icons.copy, size: 18),
                  label: const Text('복사'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnalysisMode {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  AnalysisMode(this.id, this.name, this.icon, this.color);
}