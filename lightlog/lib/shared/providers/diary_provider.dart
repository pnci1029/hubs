import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/diary_entry.dart';
import '../services/database_service.dart';
import '../services/api_service.dart';

// Diary repository provider
final diaryRepositoryProvider = Provider<DiaryRepository>((ref) {
  return DiaryRepository();
});

// Diary list provider
final diaryListProvider = StateNotifierProvider<DiaryListNotifier, AsyncValue<List<DiaryEntry>>>((ref) {
  return DiaryListNotifier(ref.read(diaryRepositoryProvider));
});

// Individual diary provider
final diaryProvider = StateNotifierProvider.family<DiaryNotifier, AsyncValue<DiaryEntry?>, String>((ref, diaryId) {
  return DiaryNotifier(ref.read(diaryRepositoryProvider), diaryId);
});

// Diary statistics provider
final diaryStatsProvider = FutureProvider<Map<String, int>>((ref) {
  return DatabaseService.instance.getDiaryStatistics();
});

// Search provider
final searchProvider = StateNotifierProvider<SearchNotifier, AsyncValue<List<DiaryEntry>>>((ref) {
  return SearchNotifier();
});

class DiaryRepository {
  final DatabaseService _db = DatabaseService.instance;
  final ApiService _api = ApiService.instance;

  Future<String> createDiary({
    required String title,
    required String content,
    required int mood,
    List<String> tags = const [],
  }) async {
    final diary = DiaryEntry(
      id: const Uuid().v4(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      mood: mood,
      tags: tags,
    );

    await _db.insertDiary(diary);
    return diary.id;
  }

  Future<void> updateDiary(DiaryEntry diary) async {
    final updatedDiary = diary.copyWith(updatedAt: DateTime.now());
    await _db.updateDiary(updatedDiary);
  }

  Future<void> deleteDiary(String id) async {
    await _db.deleteDiary(id);
  }

  Future<DiaryEntry?> getDiary(String id) async {
    return await _db.getDiary(id);
  }

  Future<DiaryEntry?> getDiaryByDate(DateTime date) async {
    return await _db.getDiaryByDate(date);
  }

  Future<List<DiaryEntry>> getAllDiaries({int? limit}) async {
    return await _db.getAllDiaries(limit: limit);
  }

  Future<List<DiaryEntry>> searchDiaries(String query) async {
    return await _db.searchDiaries(query);
  }

  Future<String> getAIAnalysis({
    required String diaryId,
    required String content,
    required String mode,
  }) async {
    // Check if analysis already exists
    final existingAnalysis = await _db.getAIAnalysis(diaryId, mode);
    if (existingAnalysis != null) {
      return existingAnalysis;
    }

    // Get new analysis from API
    final response = await _api.getAIAnalysis(
      content: content,
      mode: mode,
    );

    // Save to database
    await _db.saveAIAnalysis(
      diaryId: diaryId,
      mode: mode,
      analysis: response.analysis,
    );

    return response.analysis;
  }
}

class DiaryListNotifier extends StateNotifier<AsyncValue<List<DiaryEntry>>> {
  final DiaryRepository _repository;

  DiaryListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadDiaries();
  }

  Future<void> loadDiaries() async {
    try {
      state = const AsyncValue.loading();
      final diaries = await _repository.getAllDiaries();
      state = AsyncValue.data(diaries);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadDiaries();
  }

  Future<String> addDiary({
    required String title,
    required String content,
    required int mood,
    List<String> tags = const [],
  }) async {
    try {
      final diaryId = await _repository.createDiary(
        title: title,
        content: content,
        mood: mood,
        tags: tags,
      );
      
      // Refresh the list
      await loadDiaries();
      
      return diaryId;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateDiary(DiaryEntry diary) async {
    try {
      await _repository.updateDiary(diary);
      await loadDiaries();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteDiary(String id) async {
    try {
      await _repository.deleteDiary(id);
      await loadDiaries();
    } catch (error) {
      rethrow;
    }
  }
}

class DiaryNotifier extends StateNotifier<AsyncValue<DiaryEntry?>> {
  final DiaryRepository _repository;
  final String _diaryId;

  DiaryNotifier(this._repository, this._diaryId) : super(const AsyncValue.loading()) {
    loadDiary();
  }

  Future<void> loadDiary() async {
    try {
      state = const AsyncValue.loading();
      final diary = await _repository.getDiary(_diaryId);
      state = AsyncValue.data(diary);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<String> getAIAnalysis(String mode) async {
    final diary = state.value;
    if (diary == null) throw Exception('Diary not found');

    return await _repository.getAIAnalysis(
      diaryId: diary.id,
      content: diary.content,
      mode: mode,
    );
  }
}

class SearchNotifier extends StateNotifier<AsyncValue<List<DiaryEntry>>> {
  SearchNotifier() : super(const AsyncValue.data([]));

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    try {
      state = const AsyncValue.loading();
      final results = await DatabaseService.instance.searchDiaries(query);
      state = AsyncValue.data(results);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}