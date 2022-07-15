import 'package:flutter/material.dart';
import 'package:dairy/screens/drawing/drawn_line.dart';

class Sketcher extends CustomPainter {
  List<DrawnLine>? lines;

  Sketcher({this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    if (lines != null) {
      for (int i = 0; i < lines!.length; ++i) {
        for (int j = 0; j < lines![i].path.length - 1; ++j) {
          paint.color = lines![i].color;
          paint.strokeWidth = lines![i].width;
          canvas.drawLine(lines![i].path[j], lines![i].path[j + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }
}
