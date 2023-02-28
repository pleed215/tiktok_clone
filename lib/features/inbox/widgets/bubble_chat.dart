import 'package:flutter/material.dart';

class BubbleShape extends CustomPainter {
  final Color color;

  const BubbleShape({Key? key, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final bubbleSize = Size(size.width, size.height * 0.8);
    final fillet = bubbleSize.width * 0.03;
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(bubbleSize.width, bubbleSize.height - fillet)
      ..quadraticBezierTo(bubbleSize.width + 1.4 * fillet,
          bubbleSize.height + 2.0, bubbleSize.width - fillet, bubbleSize.height)
      ..lineTo(fillet, bubbleSize.height)
      ..quadraticBezierTo(0, bubbleSize.height, 0, bubbleSize.height - fillet)
      ..lineTo(0, fillet)
      ..quadraticBezierTo(0, 0, fillet, 0)
      ..lineTo(bubbleSize.width - fillet, 0)
      ..quadraticBezierTo(bubbleSize.width, 0, bubbleSize.width, fillet)
      ..lineTo(bubbleSize.width, fillet);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
