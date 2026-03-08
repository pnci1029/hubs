import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/genre_selection_screen.dart';
import 'screens/keyword_input_screen.dart';
import 'screens/story_reader_screen.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/genre',
      builder: (context, state) => const GenreSelectionScreen(),
    ),
    GoRoute(
      path: '/keywords',
      builder: (context, state) {
        final genre = state.extra as String?;
        return KeywordInputScreen(selectedGenre: genre ?? '');
      },
    ),
    GoRoute(
      path: '/reader',
      builder: (context, state) {
        final story = state.extra as Map<String, dynamic>?;
        return StoryReaderScreen(story: story ?? {});
      },
    ),
  ],
);

void main() {
  runApp(const ProviderScope(child: StoryApp()));
}

class StoryApp extends StatelessWidget {
  const StoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Story',
      routerConfig: _router,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B7355),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.nanumMyeongjoTextTheme(
          ThemeData.dark().textTheme,
        ),
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D2D2D),
          elevation: 0,
        ),
      ),
    );
  }
}