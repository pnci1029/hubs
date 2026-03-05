import 'package:flutter/material.dart';
import 'dart:math' as math;

// 킹크랩갓디언 - CustomPainter로 그린 버전
class KingCrabPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    // 배경 그라디언트
    final gradient = LinearGradient(
      colors: [Colors.red[700]!, Colors.orange[600]!],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    
    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // 크랩 몸체
    paint.shader = null;
    paint.color = Colors.red[800]!;
    final bodyCenter = Offset(size.width * 0.5, size.height * 0.6);
    canvas.drawOval(
      Rect.fromCenter(center: bodyCenter, width: size.width * 0.4, height: size.height * 0.3),
      paint,
    );

    // 크랩 집게발 (왼쪽)
    paint.color = Colors.red[600]!;
    final leftClaw = Path();
    leftClaw.moveTo(size.width * 0.2, size.height * 0.5);
    leftClaw.quadraticBezierTo(size.width * 0.1, size.height * 0.4, size.width * 0.05, size.height * 0.45);
    leftClaw.lineTo(size.width * 0.1, size.height * 0.55);
    leftClaw.close();
    canvas.drawPath(leftClaw, paint);

    // 크랩 집게발 (오른쪽)
    final rightClaw = Path();
    rightClaw.moveTo(size.width * 0.8, size.height * 0.5);
    rightClaw.quadraticBezierTo(size.width * 0.9, size.height * 0.4, size.width * 0.95, size.height * 0.45);
    rightClaw.lineTo(size.width * 0.9, size.height * 0.55);
    rightClaw.close();
    canvas.drawPath(rightClaw, paint);

    // 왕관
    paint.color = Colors.yellow[600]!;
    final crown = Path();
    crown.moveTo(size.width * 0.35, size.height * 0.25);
    crown.lineTo(size.width * 0.4, size.height * 0.15);
    crown.lineTo(size.width * 0.5, size.height * 0.2);
    crown.lineTo(size.width * 0.6, size.height * 0.15);
    crown.lineTo(size.width * 0.65, size.height * 0.25);
    crown.lineTo(size.width * 0.35, size.height * 0.25);
    crown.close();
    canvas.drawPath(crown, paint);

    // 눈
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.55), 4, paint);
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.55), 4, paint);

    // 방패 (가디언 표시)
    paint.color = Colors.blue[600]!;
    final shield = Path();
    shield.moveTo(size.width * 0.85, size.height * 0.15);
    shield.lineTo(size.width * 0.95, size.height * 0.2);
    shield.lineTo(size.width * 0.95, size.height * 0.35);
    shield.lineTo(size.width * 0.9, size.height * 0.4);
    shield.lineTo(size.width * 0.85, size.height * 0.35);
    shield.lineTo(size.width * 0.8, size.height * 0.4);
    shield.lineTo(size.width * 0.75, size.height * 0.35);
    shield.lineTo(size.width * 0.75, size.height * 0.2);
    shield.close();
    canvas.drawPath(shield, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// 네오살인로봇 - CustomPainter로 그린 버전
class NeoKillerRobotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // 사이버 배경
    final gradient = LinearGradient(
      colors: [Colors.black, Colors.blue[900]!, Colors.purple[900]!],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    
    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // 로봇 몸체
    paint.shader = null;
    paint.color = Colors.grey[800]!;
    final bodyRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.6),
      width: size.width * 0.3,
      height: size.height * 0.4,
    );
    canvas.drawRRect(RRect.fromRectAndRadius(bodyRect, Radius.circular(8)), paint);

    // 로봇 헤드
    paint.color = Colors.grey[700]!;
    final headRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.35),
      width: size.width * 0.25,
      height: size.height * 0.2,
    );
    canvas.drawRRect(RRect.fromRectAndRadius(headRect, Radius.circular(6)), paint);

    // 레드 바이저
    paint.color = Colors.red[600]!;
    final visorRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.35),
      width: size.width * 0.2,
      height: size.height * 0.08,
    );
    canvas.drawRRect(RRect.fromRectAndRadius(visorRect, Radius.circular(4)), paint);

    // 레이저 포인터들
    paint.color = Colors.red;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.5), 3, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.5), 3, paint);

    // NEO 라벨
    paint.color = Colors.green[600]!;
    final neoRect = Rect.fromLTWH(size.width * 0.1, size.height * 0.1, size.width * 0.2, size.height * 0.08);
    canvas.drawRRect(RRect.fromRectAndRadius(neoRect, Radius.circular(4)), paint);

    // 킬러 심볼 (해골)
    paint.color = Colors.red[600]!;
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.15), 12, paint);
    
    // 해골 눈
    paint.color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.14), 2, paint);
    canvas.drawCircle(Offset(size.width * 0.88, size.height * 0.14), 2, paint);

    // 팔
    paint.color = Colors.grey[600]!;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.2, size.height * 0.55, size.width * 0.15, size.height * 0.08), paint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.65, size.height * 0.55, size.width * 0.15, size.height * 0.08), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// 란란루 - CustomPainter로 그린 버전  
class RanranruPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // 마법적 배경
    final gradient = RadialGradient(
      colors: [Colors.pink[200]!, Colors.purple[300]!, Colors.blue[400]!],
      center: Alignment.center,
    );
    
    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // 마법 구체 외곽
    paint.shader = null;
    paint.color = Colors.purple[400]!;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.25, paint);

    // 마법 구체 내부
    final innerGradient = RadialGradient(
      colors: [Colors.white.withOpacity(0.9), Colors.pink[300]!],
    );
    paint.shader = innerGradient.createShader(Rect.fromLTWH(
      size.width * 0.3, size.height * 0.3, size.width * 0.4, size.height * 0.4));
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.2, paint);

    // 중심 에너지 코어
    paint.shader = null;
    paint.color = Colors.yellow[400]!;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.08, paint);

    // 얼굴 - 눈
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.46), 3, paint);
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.46), 3, paint);

    // 얼굴 - 입 (웃는 모양)
    final smilePath = Path();
    smilePath.addArc(
      Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.52), width: 20, height: 10),
      0, math.pi,
    );
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawPath(smilePath, paint);

    // 마법 파티클들
    paint.style = PaintingStyle.fill;
    paint.color = Colors.yellow[300]!;
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), 4, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 3, paint);
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.7), 5, paint);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.8), 4, paint);

    paint.color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.2), 2, paint);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.75), 3, paint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.4), 2, paint);

    // 별 모양 파티클
    paint.color = Colors.pink[200]!;
    _drawStar(canvas, Offset(size.width * 0.1, size.height * 0.4), 6, paint);
    _drawStar(canvas, Offset(size.width * 0.9, size.height * 0.6), 5, paint);
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    const int numPoints = 5;
    final double angle = 2 * math.pi / numPoints;
    final Path starPath = Path();
    
    for (int i = 0; i < numPoints * 2; i++) {
      double currentRadius = (i % 2 == 0) ? radius : radius * 0.5;
      double x = center.dx + currentRadius * math.cos(i * angle / 2);
      double y = center.dy + currentRadius * math.sin(i * angle / 2);
      
      if (i == 0) {
        starPath.moveTo(x, y);
      } else {
        starPath.lineTo(x, y);
      }
    }
    starPath.close();
    canvas.drawPath(starPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// 보습학원 - CustomPainter로 그린 버전
class MoistureAcademyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // 수분 배경
    final gradient = LinearGradient(
      colors: [Colors.blue[100]!, Colors.cyan[200]!, Colors.blue[300]!],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    
    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // 건물 본체
    paint.shader = null;
    paint.color = Colors.white;
    final buildingRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.6),
      width: size.width * 0.6,
      height: size.height * 0.5,
    );
    canvas.drawRRect(RRect.fromRectAndRadius(buildingRect, Radius.circular(8)), paint);

    // 지붕
    paint.color = Colors.red[400]!;
    final roofPath = Path();
    roofPath.moveTo(size.width * 0.15, size.height * 0.35);
    roofPath.lineTo(size.width * 0.5, size.height * 0.25);
    roofPath.lineTo(size.width * 0.85, size.height * 0.35);
    roofPath.lineTo(size.width * 0.15, size.height * 0.35);
    roofPath.close();
    canvas.drawPath(roofPath, paint);

    // 창문들
    paint.color = Colors.blue[100]!;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.3, size.height * 0.45, size.width * 0.12, size.height * 0.12), paint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.58, size.height * 0.45, size.width * 0.12, size.height * 0.12), paint);
    
    // 창문 프레임
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.color = Colors.blue[400]!;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.3, size.height * 0.45, size.width * 0.12, size.height * 0.12), paint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.58, size.height * 0.45, size.width * 0.12, size.height * 0.12), paint);

    // 문
    paint.style = PaintingStyle.fill;
    paint.color = Colors.brown[400]!;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.45, size.height * 0.65, size.width * 0.1, size.height * 0.2), paint);
    
    // 문손잡이
    paint.color = Colors.yellow[600]!;
    canvas.drawCircle(Offset(size.width * 0.52, size.height * 0.72), 2, paint);

    // ACADEMY 사인
    paint.color = Colors.blue[600]!;
    final signRect = Rect.fromLTWH(size.width * 0.35, size.height * 0.15, size.width * 0.3, size.height * 0.06);
    canvas.drawRRect(RRect.fromRectAndRadius(signRect, Radius.circular(3)), paint);

    // 수분 시스템들 (물방울 효과)
    paint.color = Colors.blue[600]!.withOpacity(0.7);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.2), 5, paint);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.15), 4, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.25), 6, paint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.4), 4, paint);
    
    paint.color = Colors.cyan[400]!.withOpacity(0.6);
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.8), 7, paint);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.75), 5, paint);
    canvas.drawCircle(Offset(size.width * 0.05, size.height * 0.6), 4, paint);
    canvas.drawCircle(Offset(size.width * 0.95, size.height * 0.65), 6, paint);

    // 미스트 효과
    paint.color = Colors.white.withOpacity(0.3);
    for (int i = 0; i < 10; i++) {
      double x = (i % 4) * size.width * 0.25 + size.width * 0.1;
      double y = (i ~/ 4) * size.height * 0.3 + size.height * 0.1;
      canvas.drawCircle(Offset(x, y), 2 + (i % 3), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}