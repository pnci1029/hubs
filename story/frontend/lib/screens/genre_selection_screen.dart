import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class GenreSelectionScreen extends StatefulWidget {
  const GenreSelectionScreen({super.key});

  @override
  State<GenreSelectionScreen> createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  String? selectedGenre;

  final List<Map<String, dynamic>> genres = [
    {'id': 'romance', 'name': '로맨스', 'icon': Icons.favorite_outline},
    {'id': 'fantasy', 'name': '판타지', 'icon': Icons.auto_fix_high},
    {'id': 'mystery', 'name': '미스터리', 'icon': Icons.search},
    {'id': 'scifi', 'name': 'SF', 'icon': Icons.rocket_launch},
    {'id': 'thriller', 'name': '스릴러', 'icon': Icons.flash_on},
    {'id': 'horror', 'name': '공포', 'icon': Icons.dark_mode},
    {'id': 'historical', 'name': '사극', 'icon': Icons.temple_buddhist},
    {'id': 'comedy', 'name': '코미디', 'icon': Icons.sentiment_very_satisfied},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '장르 선택',
          style: GoogleFonts.nanumMyeongjo(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '어떤 장르의 이야기를\n만들어볼까요?',
                style: GoogleFonts.nanumMyeongjo(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              
              const SizedBox(height: 32),
              
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    final genre = genres[index];
                    final isSelected = selectedGenre == genre['id'];
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGenre = genre['id'];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected 
                            ? const Color(0xFF8B7355).withOpacity(0.2)
                            : const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected 
                              ? const Color(0xFF8B7355)
                              : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              genre['icon'],
                              size: 40,
                              color: isSelected 
                                ? const Color(0xFF8B7355)
                                : Colors.grey[400],
                            ),
                            
                            const SizedBox(height: 12),
                            
                            Text(
                              genre['name'],
                              style: GoogleFonts.nanumMyeongjo(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected 
                                  ? const Color(0xFF8B7355)
                                  : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: selectedGenre != null 
                    ? () => context.go('/keywords', extra: selectedGenre)
                    : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B7355),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    '다음',
                    style: GoogleFonts.nanumMyeongjo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}