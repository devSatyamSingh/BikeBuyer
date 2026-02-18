import 'dart:math';
import 'package:flutter/material.dart';

class SegmentLoader extends StatefulWidget {
  const SegmentLoader({super.key});

  @override
  State<SegmentLoader> createState() => _SegmentLoaderState();
}

class _SegmentLoaderState extends State<SegmentLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Transform.rotate(
            angle: _controller.value * 2 * pi,
            child: CustomPaint(
              size: const Size(47, 47),
              painter: SegmentPainter(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SegmentPainter extends CustomPainter {
  final int segments = 13;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 1.6;

    for (int i = 0; i < segments; i++) {
      final angle = (2 * pi / segments) * i;
      final paint = Paint()
        ..color = Colors.purple.withOpacity((i + 1) / segments)
        ..strokeWidth = 7
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(
          center.dx + cos(angle) * (radius - 10),
          center.dy + sin(angle) * (radius - 10),
        ),
        Offset(
          center.dx + cos(angle) * radius,
          center.dy + sin(angle) * radius,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}