import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class TestCardDesign extends StatelessWidget {
  final String cardName;
  final String cardType;
  final String description;
  final int cost;
  final int mineral;
  final int attack;
  final int hp;

  const TestCardDesign({
    super.key,
    required this.cardName,
    required this.cardType,
    required this.description,
    required this.cost,
    this.mineral = 0,
    this.attack = 0,
    this.hp = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: _getCardBorderColor(),
          width: 3,
        ),
      ),
      child: Column(
        children: [
          // 카드 헤더 (카드 이름)
          Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: _getCardGradient(),
              borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: Stack(
              children: [
                // 배경 패턴
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
                    child: _buildHeaderPattern(),
                  ),
                ),
                // 카드 이름
                Center(
                  child: Text(
                    cardName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                // 코스트 뱃지
                if (cost > 0)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          cost.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // 메인 일러스트 영역
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: _buildCardIllustration(),
              ),
            ),
          ),
          
          // 카드 설명
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black87,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // 능력치 표시
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (mineral > 0)
                  _buildStatChip(
                    Icons.diamond,
                    mineral.toString(),
                    Colors.amber,
                    "미네랄",
                  ),
                if (attack > 0)
                  _buildStatChip(
                    Icons.flash_on,
                    attack.toString(),
                    Colors.red,
                    "공격",
                  ),
                if (hp > 0)
                  _buildStatChip(
                    Icons.favorite,
                    hp.toString(),
                    Colors.green,
                    "체력",
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardIllustration() {
    switch (cardName) {
      case "드론 자판기":
        return Stack(
          fit: StackFit.expand,
          children: [
            // 배경
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple[100]!,
                    Colors.purple[200]!,
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            // 자판기 모양
            Positioned(
              left: 30,
              top: 20,
              child: Container(
                width: 60,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Column(
                  children: [
                    // 자판기 상단 디스플레이
                    Container(
                      margin: EdgeInsets.all(4),
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    // 자판기 버튼들
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(9, (index) {
                          return Container(
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 드론들
            Positioned(
              right: 10,
              top: 15,
              child: Icon(
                Icons.smart_toy,
                color: Colors.purple[800],
                size: 25,
              ),
            ),
            Positioned(
              right: 15,
              top: 45,
              child: Icon(
                Icons.smart_toy,
                color: Colors.purple[800],
                size: 20,
              ),
            ),
            Positioned(
              right: 25,
              top: 70,
              child: Icon(
                Icons.smart_toy,
                color: Colors.purple[800],
                size: 18,
              ),
            ),
            // 화살표 (드론이 나오는 표시)
            Positioned(
              left: 95,
              top: 40,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        );
      
      case "핵 스나이퍼":
        return Stack(
          fit: StackFit.expand,
          children: [
            // 배경
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red[100]!,
                    Colors.orange[200]!,
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            // 스나이퍼 실루엣
            Positioned(
              left: 15,
              top: 30,
              child: Container(
                width: 80,
                height: 40,
                child: Stack(
                  children: [
                    // 총신
                    Positioned(
                      left: 0,
                      top: 18,
                      child: Container(
                        width: 60,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    // 스코프
                    Positioned(
                      left: 25,
                      top: 12,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                      ),
                    ),
                    // 개머리판
                    Positioned(
                      right: 5,
                      top: 15,
                      child: Container(
                        width: 15,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.brown[600],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 핵 표시
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Icon(
                  Icons.warning,
                  color: Colors.black,
                  size: 15,
                ),
              ),
            ),
            // 조준선
            Positioned(
              left: 50,
              top: 70,
              child: Container(
                width: 30,
                height: 30,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 2,
                        height: 25,
                        color: Colors.red,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 25,
                        height: 2,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      
      default:
        return Center(
          child: Icon(
            Icons.help_outline,
            size: 50,
            color: Colors.grey,
          ),
        );
    }
  }

  Widget _buildStatChip(IconData icon, String value, Color color, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderPattern() {
    switch (cardType) {
      case "resource":
        return SizedBox.expand(
          child: CustomPaint(
            painter: DiamondPatternPainter(Colors.white.withOpacity(0.1)),
          ),
        );
      case "unit":
        return SizedBox.expand(
          child: CustomPaint(
            painter: SwordPatternPainter(Colors.white.withOpacity(0.1)),
          ),
        );
      default:
        return Container();
    }
  }

  LinearGradient _getCardGradient() {
    switch (cardType) {
      case "resource":
        return LinearGradient(
          colors: [Colors.green[600]!, Colors.green[800]!],
        );
      case "unit":
        return LinearGradient(
          colors: [Colors.red[600]!, Colors.red[800]!],
        );
      case "effect":
        return LinearGradient(
          colors: [Colors.blue[600]!, Colors.blue[800]!],
        );
      case "magic":
        return LinearGradient(
          colors: [Colors.purple[600]!, Colors.purple[800]!],
        );
      default:
        return LinearGradient(
          colors: [Colors.grey[600]!, Colors.grey[800]!],
        );
    }
  }

  Color _getCardBorderColor() {
    // 카드 등급에 따른 테두리 색상
    if (cost >= 8) return Colors.amber; // 레전더리
    if (cost >= 5) return Colors.purple; // 에픽
    if (cost >= 3) return Colors.blue; // 레어
    return Colors.grey; // 일반
  }
}

// 다이아몬드 패턴 페인터
class DiamondPatternPainter extends CustomPainter {
  final Color color;

  DiamondPatternPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < size.width ~/ 15; i++) {
      for (int j = 0; j < size.height ~/ 15; j++) {
        final path = Path();
        final centerX = i * 15.0 + 7.5;
        final centerY = j * 15.0 + 7.5;
        
        path.moveTo(centerX, centerY - 3);
        path.lineTo(centerX + 3, centerY);
        path.lineTo(centerX, centerY + 3);
        path.lineTo(centerX - 3, centerY);
        path.close();
        
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 검 패턴 페인터
class SwordPatternPainter extends CustomPainter {
  final Color color;

  SwordPatternPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < size.width ~/ 20; i++) {
      for (int j = 0; j < size.height ~/ 20; j++) {
        final centerX = i * 20.0 + 10;
        final centerY = j * 20.0 + 10;
        
        // 검 모양
        final rect = Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: 2,
          height: 8,
        );
        canvas.drawRect(rect, paint);
        
        // 검 손잡이
        final handleRect = Rect.fromCenter(
          center: Offset(centerX, centerY + 3),
          width: 4,
          height: 2,
        );
        canvas.drawRect(handleRect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}