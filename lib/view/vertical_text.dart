import 'dart:math';
import 'package:flutter/material.dart';

class VerticalText extends CustomPainter {
  Paint mPaint;
  String text;
  Size size;
  TextStyle textStyle;

  VerticalText(
    {@required this.text,
    @required this.size,
    @required this.textStyle}) {
      mPaint = new Paint();
      mPaint.color = textStyle.color;
    }

  double findMaxWidth(String text, TextStyle style) {
    double maxWidth = 0;
    for (int i = 0; i < text.length; i++) {
      TextSpan span = new TextSpan(style: style, text: text[i]);
      TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr
      );
      tp.layout();
      maxWidth = max(maxWidth, tp.width);
    }
    return maxWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {

    double offsetX = size.width;
    double offsetY = 0;
    bool newLine = true;

    for (int i = 0; i < text.length; i++) {
      TextSpan span = new TextSpan(style: textStyle, text: text[i]);
      TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp.layout();

      if (offsetY + tp.height > size.height) {
        newLine = true;
        offsetY = 0;
      }

      if (newLine) {
        offsetX -= tp.width;
        newLine = false;
      }

      if (offsetX < -tp.width) {
        break;
      }

      tp.paint(canvas, new Offset(offsetX, offsetY));
      offsetY += tp.height;
    }
  }

  @override
  bool shouldRepaint(VerticalText oldDelegate) {
    return oldDelegate.text != text ||
    oldDelegate.textStyle != textStyle ||
    oldDelegate.size != size;
  }
}
