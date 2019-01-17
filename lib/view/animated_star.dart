import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedStar extends CustomPainter {

  Paint mPaint;
  BuildContext context;
  double R;
  int n;
  Color color;

  final deg2Rad = (double deg) => (deg * pi / 180);

  AnimatedStar(this.context, [this.R = 60, this.n = 5, this.color = Colors.orange]) {
    mPaint = new Paint();
    mPaint.style = PaintingStyle.stroke;
    mPaint.color = Colors.deepOrange;
    mPaint.isAntiAlias = true;
  }

  // 网格
  Path gridPath(int step, Size winSize) {
    Path path = new Path();
    for (int i = 0; i < winSize.height / step + 1; i++) {
      path.moveTo(0, step * i.toDouble());
      path.lineTo(winSize.width, step * i.toDouble());
    }

    for (int i = 0; i < winSize.width / step + 1; i++) {
      path.moveTo(step * i.toDouble(), 0);
      path.lineTo(step * i.toDouble(), winSize.height);
    }
    return path;
  }

  // 坐标轴
  Path axisPath(Offset point, Size winSize) {
    Path path = new Path();
    // x 正轴
    path.moveTo(point.dx, point.dy);
    path.lineTo(winSize.width, point.dy);

    // x 负轴
    path.moveTo(point.dx, point.dy);
    path.lineTo(0, point.dy);

    // y 正轴
    path.moveTo(point.dx, point.dy);
    path.lineTo(point.dx, 0);

    // y 负轴
    path.moveTo(point.dx, point.dy);
    path.lineTo(point.dx, winSize.height);

    return path;
  }

  // 绘制文字
  ui.Paragraph getParagraph(String text, Color color, double width) {
    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontSize: 10.0,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )
    )
    ..pushStyle(ui.TextStyle(color: color))
    ..addText(text);

    return paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: width));
  }

  // 画坐标轴
  void drawXYAxis(Canvas canvas, Offset point, Size winSize) {
    Paint paint = new Paint();
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;

    canvas.drawPath(axisPath(point, winSize), paint);

    canvas.drawLine(Offset(winSize.width, point.dy), Offset(winSize.width - 10, point.dy - 6), paint);
    canvas.drawLine(Offset(winSize.width, point.dy), Offset(winSize.width - 10, point.dy + 6), paint);

    canvas.drawLine(Offset(point.dx, 0), Offset(point.dx - 6, 10), paint);
    canvas.drawLine(Offset(point.dx, 0), Offset(point.dx + 6, 10), paint);

    canvas.drawParagraph(getParagraph('x轴', Colors.black87, 30), Offset(winSize.width - 30, point.dy));
    canvas.drawParagraph(getParagraph('y轴', Colors.black87, 30), Offset(point.dx + 4, 10));
  }

  Path starPath(int n, double R, double r) {
    Path path = new Path();
    double deg = 360 / n;
    double degA = deg / 4;
    double degB = deg - degA; //360 / (count - 1) / 2 - degA / 2 + degA;
    path.moveTo(cos(deg2Rad(degA)) * R, -sin(deg2Rad(degA)) * R);
    for (int i = 0; i < n; i++) {
      path.lineTo(cos(deg2Rad(degA + deg * i)) * R, -sin(deg2Rad(degA + deg * i)) * R);
      path.lineTo(cos(deg2Rad(degB + deg * i)) * r, -sin(deg2Rad(degB + deg * i)) * r);
    }
    path.close();
    return path;
  }

  void drawStar(Canvas canvas, int n, double R, double r) {
    Paint paint = new Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(starPath(n, R, r), paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var winSize = MediaQuery.of(context).size;
    canvas.drawPath(gridPath(20, winSize), mPaint);

    Offset point = Offset(winSize.width * 0.5, winSize.height * 0.5);
    drawXYAxis(canvas, point, winSize);

    canvas.translate(point.dx, point.dy);
    drawStar(canvas, n, R, 20);
  }

  @override
  bool shouldRepaint(AnimatedStar oldDelegate) {
    return oldDelegate.R != R || oldDelegate.n != n || oldDelegate.color != color;
  }
}
