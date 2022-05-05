import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.7, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    //paint.color = Colors.blue.shade300;
    paint.shader = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(size.width * 0.5, size.height),
      [
        Colors.blue.shade600,
        Colors.blue.shade200,
      ],
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}