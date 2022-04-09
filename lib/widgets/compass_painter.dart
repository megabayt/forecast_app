import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CompassPainter extends CustomPainter {
  final Paint tickPaint;
  final TextPainter textPainter;
  final double rotate;

  CompassPainter({required double rotate})
      : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        rotate = (rotate * pi / 180) {
    tickPaint.color = Colors.blueGrey;
  }

  @override
  void paint(Canvas canvas, Size size) {
    const angle = 2 * pi / 36;
    final radius = size.width / 2;
    canvas.save();

    // drawing
    canvas.translate(radius, radius);
    List<int> skipIList = const [0, 1, 2, 3, 4];
    for (var i = 0; i < 36; i++) {
      if (!skipIList.contains((i + 2) % 9)) {
        canvas.drawLine(
          Offset(0.0, -radius),
          Offset(0.0, -radius + 5),
          tickPaint,
        );
      }
      if (i % 9 == 0) {
        // //draw the text
        textPainter.text = TextSpan(
          text: (() {
            if (i == 0) {
              return 'N';
            }
            if (i == 9) {
              return 'E';
            }
            if (i == 18) {
              return 'S';
            }
            if (i == 27) {
              return 'W';
            }
          })(),
          style: TextStyle(
            color: i == 0 ? Colors.red : Colors.black,
            fontFamily: 'Times New Roman',
            fontSize: 15.0,
          ),
        );

        //helps make the text painted vertically
        textPainter.layout();

        canvas.save();
        canvas.translate(0.0, -radius + textPainter.width / 2);
        canvas.rotate(-angle * i);

        textPainter.paint(canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)));

        canvas.restore();
      }

      canvas.rotate(angle);
    }

    canvas.rotate(rotate);

    var vertices = Vertices(
      VertexMode.triangles,
      [const Offset(5, 0), const Offset(-5, 0), Offset(0, radius - 15)],
    );

    canvas.drawVertices(
      vertices,
      BlendMode.srcOver,
      Paint()..color = Colors.blue,
    );
    canvas.drawLine(Offset.zero, Offset(0, -radius + 15), tickPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
