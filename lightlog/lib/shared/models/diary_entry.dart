class DiaryEntry {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? aiAnalysis;
  final int mood; // 1-5 scale
  final List<String> tags;

  DiaryEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.aiAnalysis,
    required this.mood,
    this.tags = const [],
  });

  DiaryEntry copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? aiAnalysis,
    int? mood,
    List<String>? tags,
  }) {
    return DiaryEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      aiAnalysis: aiAnalysis ?? this.aiAnalysis,
      mood: mood ?? this.mood,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'aiAnalysis': aiAnalysis,
      'mood': mood,
      'tags': tags,
    };
  }

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      aiAnalysis: json['aiAnalysis'] as String?,
      mood: json['mood'] as int,
      tags: List<String>.from(json['tags'] as List? ?? []),
    );
  }

  @override
  String toString() {
    return 'DiaryEntry(id: $id, title: $title, mood: $mood)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DiaryEntry && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}