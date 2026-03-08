import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              
              Text(
                'Story',
                style: GoogleFonts.nanumMyeongjo(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF8B7355),
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'AI로 만드는 당신만의 이야기',
                style: GoogleFonts.nanumMyeongjo(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
              
              const Spacer(),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.auto_stories,
                      color: const Color(0xFF8B7355),
                      size: 32,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      '새로운 이야기 만들기',
                      style: GoogleFonts.nanumMyeongjo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      '장르와 키워드를 선택하면\nAI가 당신만의 소설을 만들어드립니다',
                      style: GoogleFonts.nanumMyeongjo(
                        fontSize: 14,
                        color: Colors.grey[400],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => context.go('/genre'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B7355),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    '시작하기',
                    style: GoogleFonts.nanumMyeongjo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}