import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/diary_entry.dart';

class DatabaseService {
  static DatabaseService? _instance;
  static Database? _database;

  DatabaseService._internal();

  static DatabaseService get instance {
    _instance ??= DatabaseService._internal();
    return _instance!;
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'lightlog.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    // Diary entries table
    await db.execute('''
      CREATE TABLE diary_entries (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        mood INTEGER NOT NULL DEFAULT 3,
        tags TEXT DEFAULT '[]'
      )
    ''');

    // AI analysis table
    await db.execute('''
      CREATE TABLE ai_analysis (
        id TEXT PRIMARY KEY,
        diary_id TEXT NOT NULL,
        mode TEXT NOT NULL,
        analysis TEXT NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (diary_id) REFERENCES diary_entries (id) ON DELETE CASCADE
      )
    ''');

    // User settings table
    await db.execute('''
      CREATE TABLE user_settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Search index for full-text search
    await db.execute('''
      CREATE VIRTUAL TABLE diary_search USING fts5(
        id UNINDEXED,
        title,
        content,
        content='diary_entries',
        content_rowid='rowid'
      )
    ''');

    // Triggers to keep search index updated
    await db.execute('''
      CREATE TRIGGER diary_ai AFTER INSERT ON diary_entries BEGIN
        INSERT INTO diary_search(id, title, content) VALUES (NEW.id, NEW.title, NEW.content);
      END;
    ''');

    await db.execute('''
      CREATE TRIGGER diary_au AFTER UPDATE ON diary_entries BEGIN
        UPDATE diary_search SET title=NEW.title, content=NEW.content WHERE id=NEW.id;
      END;
    ''');

    await db.execute('''
      CREATE TRIGGER diary_ad AFTER DELETE ON diary_entries BEGIN
        DELETE FROM diary_search WHERE id=OLD.id;
      END;
    ''');

    print('✅ Database tables created successfully');
  }

  // Diary CRUD operations
  Future<String> insertDiary(DiaryEntry diary) async {
    final db = await database;
    await db.insert(
      'diary_entries',
      diary.toJson()..remove('aiAnalysis'), // Remove computed field
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return diary.id;
  }

  Future<void> updateDiary(DiaryEntry diary) async {
    final db = await database;
    await db.update(
      'diary_entries',
      diary.toJson()..remove('aiAnalysis'),
      where: 'id = ?',
      whereArgs: [diary.id],
    );
  }

  Future<void> deleteDiary(String id) async {
    final db = await database;
    await db.delete(
      'diary_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<DiaryEntry?> getDiary(String id) async {
    final db = await database;
    final results = await db.query(
      'diary_entries',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) return null;
    
    return DiaryEntry.fromJson(results.first);
  }

  Future<DiaryEntry?> getDiaryByDate(DateTime date) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    
    final results = await db.query(
      'diary_entries',
      where: 'DATE(created_at) = ?',
      whereArgs: [dateStr],
      limit: 1,
      orderBy: 'created_at DESC',
    );

    if (results.isEmpty) return null;
    
    return DiaryEntry.fromJson(results.first);
  }

  Future<List<DiaryEntry>> getAllDiaries({
    int? limit,
    int? offset,
    String? orderBy,
  }) async {
    final db = await database;
    final results = await db.query(
      'diary_entries',
      orderBy: orderBy ?? 'created_at DESC',
      limit: limit,
      offset: offset,
    );

    return results.map((json) => DiaryEntry.fromJson(json)).toList();
  }

  Future<List<DiaryEntry>> searchDiaries(String query) async {
    final db = await database;
    
    // Use FTS for full-text search
    final results = await db.rawQuery('''
      SELECT de.* FROM diary_entries de
      JOIN diary_search ds ON de.id = ds.id
      WHERE diary_search MATCH ?
      ORDER BY rank
    ''', ['$query*']); // Add wildcard for partial matches

    return results.map((json) => DiaryEntry.fromJson(json)).toList();
  }

  Future<Map<String, int>> getDiaryStatistics() async {
    final db = await database;
    
    // Total count
    final totalResult = await db.rawQuery('SELECT COUNT(*) as count FROM diary_entries');
    final totalCount = totalResult.first['count'] as int;

    // This month count
    final now = DateTime.now();
    final thisMonth = DateTime(now.year, now.month, 1).toIso8601String();
    final nextMonth = DateTime(now.year, now.month + 1, 1).toIso8601String();
    
    final monthResult = await db.rawQuery('''
      SELECT COUNT(*) as count FROM diary_entries 
      WHERE created_at >= ? AND created_at < ?
    ''', [thisMonth, nextMonth]);
    final monthCount = monthResult.first['count'] as int;

    // Get dates for streak calculation
    final datesResult = await db.rawQuery('''
      SELECT DISTINCT DATE(created_at) as date FROM diary_entries 
      ORDER BY date DESC
    ''');
    
    final dates = datesResult.map((row) => DateTime.parse(row['date'] as String)).toList();
    
    // Calculate current and longest streak
    int currentStreak = _calculateCurrentStreak(dates);
    int longestStreak = _calculateLongestStreak(dates);

    return {
      'total': totalCount,
      'thisMonth': monthCount,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
    };
  }

  int _calculateCurrentStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;
    
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));
    
    // Check if there's an entry today or yesterday to start streak
    bool hasRecentEntry = dates.any((date) => 
      _isSameDay(date, today) || _isSameDay(date, yesterday)
    );
    
    if (!hasRecentEntry) return 0;
    
    int streak = 0;
    DateTime checkDate = today;
    
    while (dates.any((date) => _isSameDay(date, checkDate))) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    
    return streak;
  }

  int _calculateLongestStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;
    
    int longestStreak = 0;
    int currentStreak = 1;
    
    for (int i = 1; i < dates.length; i++) {
      final current = dates[i];
      final previous = dates[i - 1];
      
      // Check if consecutive days
      if (previous.difference(current).inDays == 1) {
        currentStreak++;
      } else {
        longestStreak = currentStreak > longestStreak ? currentStreak : longestStreak;
        currentStreak = 1;
      }
    }
    
    return currentStreak > longestStreak ? currentStreak : longestStreak;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  // AI Analysis operations
  Future<void> saveAIAnalysis({
    required String diaryId,
    required String mode,
    required String analysis,
  }) async {
    final db = await database;
    await db.insert(
      'ai_analysis',
      {
        'id': '${diaryId}_$mode',
        'diary_id': diaryId,
        'mode': mode,
        'analysis': analysis,
        'created_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getAIAnalysis(String diaryId, String mode) async {
    final db = await database;
    final results = await db.query(
      'ai_analysis',
      where: 'diary_id = ? AND mode = ?',
      whereArgs: [diaryId, mode],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return results.first['analysis'] as String;
  }

  // User settings
  Future<void> saveSetting(String key, String value) async {
    final db = await database;
    await db.insert(
      'user_settings',
      {
        'key': key,
        'value': value,
        'updated_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getSetting(String key) async {
    final db = await database;
    final results = await db.query(
      'user_settings',
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return results.first['value'] as String;
  }

  // Database utilities
  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('diary_entries');
    await db.delete('ai_analysis');
    await db.delete('user_settings');
  }
}