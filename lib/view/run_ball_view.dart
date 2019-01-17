
import 'package:flutter/material.dart';

class Ball {
  double aX; // X轴方向加速度
  double aY; // Y轴方向加速度
  double vX; // X轴方向速度
  double vY; // Y轴方向速度
  double x; // X坐标
  double y; // Y坐标
  Color color; // 小球颜色
  double r; // 小球半径

  Ball({this.x, this.y, this.color, this.r, this.aX, this.aY, this.vX, this.vY});

  Ball.fromBall(Ball ball) {
    this.x = ball.x;
    this.y = ball.y;
    this.vX = -ball.vX;
    this.vY = -ball.vY;
    this.aX = ball.aX;
    this.aY = ball.aY;
    this.color = ball.color;
    this.r = ball.r;
  }

  // Ball.halfBall(Ball ball) {
  //   this.x = ball.x;
  //   this.y = ball.y;

  //   this.aX = ball.aX;
  //   this.aY = ball.aY;
  //   this.color = ball.color;

  //   this.vX = -ball.vX;
  //   this.vY = -ball.vY;
  //   this.r = ball.r * 0.5;
  // }
}

class RunBallView extends CustomPainter {
  BuildContext context;
  Paint _mPaint;
  List<Ball> _balls;
  Rect _limit;

  RunBallView(this.context, List<Ball> balls, Rect limit) {
    _mPaint = new Paint();
    _balls = balls;
    _limit = limit;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Size winSize = MediaQuery.of(context).size;
    canvas.translate(winSize.width * 0.5, winSize.height * 0.4);

    _mPaint.color = Color.fromARGB(148, 198, 246, 248);
    canvas.drawRect(_limit, _mPaint);

    canvas.save();
    drawBalls(canvas);
    canvas.restore();
  }

  void drawBalls(Canvas canvas) {
    for (Ball ball in _balls) {
      _mPaint.color = ball.color;
      canvas.drawCircle(Offset(ball.x, ball.y), ball.r, _mPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
