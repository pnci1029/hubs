import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/auth_screen.dart';
import 'features/diary/home_screen.dart';
import 'features/diary/diary_write_screen.dart';
import 'features/calendar/calendar_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);
  
  runApp(
    const ProviderScope(
      child: LightLogApp(),
    ),
  );
}

class LightLogApp extends StatelessWidget {
  const LightLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LightLog',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      locale: const Locale('ko', 'KR'),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/write',
      builder: (context, state) {
        final diaryId = state.uri.queryParameters['id'];
        return DiaryWriteScreen(diaryId: diaryId);
      },
    ),
    GoRoute(
      path: '/calendar',
      builder: (context, state) => const CalendarScreen(),
    ),
  ],
);