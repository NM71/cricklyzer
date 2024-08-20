import 'package:flutter/material.dart';

class GradientBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(
      colors: [
        Color(0xffe73c2f),
        Color(0xfff9b604),
        Color(0xff2ea34b),
        Color(0xff3c7ff3),
      ],
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4; // Adjust the border width as needed

    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(4)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
