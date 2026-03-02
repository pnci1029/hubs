import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/models/diary_entry.dart';
import '../../shared/providers/diary_provider.dart';
import '../../shared/widgets/ai_analysis_panel.dart';
import '../../shared/widgets/mood_selector.dart';

class DiaryWriteScreen extends ConsumerStatefulWidget {
  final String? diaryId;

  const DiaryWriteScreen({
    super.key,
    this.diaryId,
  });

  @override
  ConsumerState<DiaryWriteScreen> createState() => _DiaryWriteScreenState();
}

class _DiaryWriteScreenState extends ConsumerState<DiaryWriteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  
  bool _isLoading = false;
  bool _hasUnsavedChanges = false;
  int _selectedMood = 3;
  List<String> _tags = [];
  DiaryEntry? _originalDiary;
  bool _showAIPanel = false;

  @override
  void initState() {
    super.initState();
    _loadDiary();
    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (!_hasUnsavedChanges) {
      setState(() {
        _hasUnsavedChanges = true;
      });
    }
  }

  Future<void> _loadDiary() async {
    if (widget.diaryId == null) return;

    try {
      final diary = await ref.read(diaryRepositoryProvider).getDiary(widget.diaryId!);
      if (diary != null) {
        setState(() {
          _originalDiary = diary;
          _titleController.text = diary.title;
          _contentController.text = diary.content;
          _selectedMood = diary.mood;
          _tags = List.from(diary.tags);
          _hasUnsavedChanges = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('일기를 불러오는데 실패했습니다: $e')),
        );
      }
    }
  }

  Future<void> _saveDiary() async {
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('일기 내용을 입력해주세요')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final repository = ref.read(diaryRepositoryProvider);
      
      if (_originalDiary != null) {
        // Update existing diary
        final updatedDiary = _originalDiary!.copyWith(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          mood: _selectedMood,
          tags: _tags,
        );
        
        await repository.updateDiary(updatedDiary);
        ref.invalidate(diaryListProvider);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('일기가 수정되었습니다')),
          );
        }
      } else {
        // Create new diary
        await ref.read(diaryListProvider.notifier).addDiary(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          mood: _selectedMood,
          tags: _tags,
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('일기가 저장되었습니다')),
          );
        }
      }

      setState(() {
        _hasUnsavedChanges = false;
      });

      if (mounted) {
        context.pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('저장 실패: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _toggleAIPanel() {
    setState(() {
      _showAIPanel = !_showAIPanel;
    });
  }

  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('변경사항이 있습니다'),
        content: const Text('저장하지 않고 나가시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('나가기'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        
        final shouldPop = await _onWillPop();
        if (shouldPop && mounted) {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.diaryId != null ? '일기 수정' : '일기 쓰기'),
          actions: [
            if (_contentController.text.trim().isNotEmpty)
              IconButton(
                onPressed: _toggleAIPanel,
                icon: Icon(
                  _showAIPanel ? Icons.psychology : Icons.psychology_outlined,
                  color: _showAIPanel ? Theme.of(context).colorScheme.primary : null,
                ),
                tooltip: 'AI 분석',
              ),
            IconButton(
              onPressed: _isLoading ? null : _saveDiary,
              icon: _isLoading 
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
              tooltip: '저장',
            ),
          ],
        ),
        body: Column(
          children: [
            // Write area
            Expanded(
              flex: _showAIPanel ? 1 : 2,
              child: SingleChildScrollView(
                padding: AppTheme.paddingMedium,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date display
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        DateFormat('yyyy년 M월 d일 EEEE', 'ko_KR').format(
                          _originalDiary?.createdAt ?? DateTime.now(),
                        ),
                        style: AppTheme.bodySmall.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Title input
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: '제목을 입력하세요 (선택사항)',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: AppTheme.heading2,
                      maxLines: 2,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Mood selector
                    MoodSelector(
                      selectedMood: _selectedMood,
                      onMoodChanged: (mood) {
                        setState(() {
                          _selectedMood = mood;
                          _hasUnsavedChanges = true;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Content input
                    TextField(
                      controller: _contentController,
                      focusNode: _contentFocusNode,
                      decoration: InputDecoration(
                        hintText: AppConstants.aiPrompts[
                          DateTime.now().day % AppConstants.aiPrompts.length
                        ],
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: AppTheme.bodyLarge.copyWith(height: 1.6),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                    
                    const SizedBox(height: 100), // Bottom padding
                  ],
                ),
              ),
            ),
            
            // AI analysis panel
            if (_showAIPanel && _contentController.text.trim().isNotEmpty)
              Expanded(
                flex: 1,
                child: AIAnalysisPanel(
                  content: _contentController.text.trim(),
                  diaryId: _originalDiary?.id,
                ),
              ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 8,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Character count
              Text(
                '${_contentController.text.length}/${AppConstants.maxDiaryLength}',
                style: AppTheme.caption.copyWith(
                  color: _contentController.text.length > AppConstants.maxDiaryLength 
                    ? Colors.red 
                    : Colors.grey[600],
                ),
              ),
              
              const Spacer(),
              
              // Quick actions
              if (_contentController.text.trim().isNotEmpty && !_showAIPanel)
                FilledButton.icon(
                  onPressed: _toggleAIPanel,
                  icon: const Icon(Icons.psychology_outlined, size: 18),
                  label: const Text('AI 분석'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}