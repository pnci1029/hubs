import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

class KeywordInputScreen extends StatefulWidget {
  final String selectedGenre;

  const KeywordInputScreen({super.key, required this.selectedGenre});

  @override
  State<KeywordInputScreen> createState() => _KeywordInputScreenState();
}

class _KeywordInputScreenState extends State<KeywordInputScreen> {
  final TextEditingController _keywordController = TextEditingController();
  final List<String> _keywords = [];
  bool _isGenerating = false;

  void _addKeyword() {
    final keyword = _keywordController.text.trim();
    if (keyword.isNotEmpty && !_keywords.contains(keyword)) {
      setState(() {
        _keywords.add(keyword);
        _keywordController.clear();
      });
    }
  }

  void _removeKeyword(String keyword) {
    setState(() {
      _keywords.remove(keyword);
    });
  }

  Future<void> _generateStory() async {
    if (_keywords.isEmpty) return;

    setState(() {
      _isGenerating = true;
    });

    try {
      final dio = Dio();
      final response = await dio.post(
        'http://localhost:3000/api/generate-story',
        data: {
          'genre': widget.selectedGenre,
          'keywords': _keywords,
        },
      );

      if (response.statusCode == 200) {
        final story = response.data['story'];
        if (mounted) {
          context.go('/reader', extra: story);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('스토리 생성에 실패했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '키워드 입력',
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
                '이야기에 포함될\n키워드를 입력해주세요',
                style: GoogleFonts.nanumMyeongjo(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                '선택된 장르: ${_getGenreName(widget.selectedGenre)}',
                style: GoogleFonts.nanumMyeongjo(
                  fontSize: 14,
                  color: const Color(0xFF8B7355),
                ),
              ),
              
              const SizedBox(height: 32),
              
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _keywordController,
                      style: GoogleFonts.nanumMyeongjo(),
                      decoration: InputDecoration(
                        hintText: '키워드를 입력하세요',
                        hintStyle: GoogleFonts.nanumMyeongjo(
                          color: Colors.grey[500],
                        ),
                        filled: true,
                        fillColor: const Color(0xFF2D2D2D),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _addKeyword(),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  IconButton(
                    onPressed: _addKeyword,
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF8B7355),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              if (_keywords.isNotEmpty) ...[
                Text(
                  '추가된 키워드',
                  style: GoogleFonts.nanumMyeongjo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _keywords.map((keyword) {
                    return Chip(
                      label: Text(
                        keyword,
                        style: GoogleFonts.nanumMyeongjo(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: const Color(0xFF8B7355),
                      deleteIcon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                      onDeleted: () => _removeKeyword(keyword),
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 32),
              ],
              
              const Spacer(),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _keywords.isNotEmpty && !_isGenerating
                    ? _generateStory
                    : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B7355),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isGenerating
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                    : Text(
                        '스토리 생성하기',
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

  String _getGenreName(String genreId) {
    const genreNames = {
      'romance': '로맨스',
      'fantasy': '판타지',
      'mystery': '미스터리',
      'scifi': 'SF',
      'thriller': '스릴러',
      'horror': '공포',
      'historical': '사극',
      'comedy': '코미디',
    };
    return genreNames[genreId] ?? genreId;
  }
}