import 'package:cinema/core/constant/color.dart';
import 'package:flutter/material.dart';

class CurvedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 0),
      painter: ConcaveLinePainter(),
    );
  }
}

class ConcaveLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColor.lightRed
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Create the path for the concave curve
    Path path = Path();
    path.moveTo(0, size.height); // Start from the bottom left corner
    path.quadraticBezierTo(size.width / 2, size.height - 100, size.width,
        size.height); // Draw the concave curve
    path.lineTo(size.width, 0); // Draw line to the top right corner (optional)

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No need to repaint
  }
}
