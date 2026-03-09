import 'package:flutter/material.dart';

// 카드 디자인용 CustomPainter 클래스들

// 하트 모양을 그리는 CustomPainter
class HeartPainter extends CustomPainter {
  final Color color;

  HeartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final width = size.width;
    final height = size.height;

    // 하트 모양 경로
    path.moveTo(width / 2, height * 0.75);
    path.cubicTo(width * 0.2, height * 0.1, -width * 0.25, height * 0.6, width / 2, height);
    path.moveTo(width / 2, height * 0.75);
    path.cubicTo(width * 0.8, height * 0.1, width * 1.25, height * 0.6, width / 2, height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// SmilePainter 클래스 - 고양이 입 그리기용
class SmilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height);
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}