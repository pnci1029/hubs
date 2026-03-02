class AppConstants {
  static const String appName = 'LightLog';
  static const String appDescription = 'AI powered diary app for emotional healing';
  
  static const int maxDiaryLength = 5000;
  static const int minDiaryLength = 10;
  
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration debounceDelay = Duration(milliseconds: 500);
  
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'M월 d일';
  static const String displayDateTimeFormat = 'M월 d일 HH:mm';
  
  static const List<String> aiPrompts = [
    '오늘 하루는 어떠셨나요? 자유롭게 적어보세요.',
    '작은 행복이라도 찾아서 기록해보세요.',
    '오늘 감사했던 일이 있다면 적어주세요.',
    '힘들었던 순간도 성장의 기회가 될 수 있어요.',
    '오늘의 감정을 솔직하게 표현해보세요.',
  ];
  
  static const List<String> encouragementMessages = [
    '오늘도 수고하셨어요 ✨',
    '작은 변화도 성장입니다 🌱',
    '당신의 이야기가 소중해요 💝',
    '힘든 하루도 의미가 있어요 🌟',
    '내일은 더 좋은 날이 될 거예요 🌈',
  ];
}