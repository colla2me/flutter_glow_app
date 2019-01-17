import 'dart:math';
import 'package:flutter/material.dart';
import '../view/run_ball_view.dart';

class RunBallPage extends StatefulWidget {
  @override
  _RunBallPageState createState() => _RunBallPageState();
}

class _RunBallPageState extends State<RunBallPage> with SingleTickerProviderStateMixin {

  List<Ball> _balls;
  AnimationController controller;
  // Ball _ball;
  Rect _limit;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _balls = List<Ball>();

    _limit = Rect.fromLTRB(-140, -100, 140, 100);

    controller = AnimationController(duration: const Duration(milliseconds: 20000), vsync: this);

    controller.addListener(() {
      for (int i = 0; i < _balls.length; i++) {
        var ball = _balls[i];
        if (ball.r < 0.25) {
          _balls.removeAt(i);
        }
        updateBall(ball);
      }
      if (_balls.length > 0) {
        setState(() {});
      } else {
        controller.stop();
        print('stopped');
      }
    });

    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  void updateBall(Ball _ball) {
    _ball.x += _ball.vX;
    _ball.y += _ball.vY;
    _ball.vX += _ball.aX;
    _ball.vY += _ball.aY;

    // 触底
    if (_ball.y > _limit.bottom - _ball.r) {
      _ball.r = _ball.r * 0.5;
      var smallBall = Ball.fromBall(_ball);
      _balls.add(smallBall);

      _ball.y = _limit.bottom - _ball.r;
      _ball.vY = -_ball.vY;
      _ball.color = randomRGB();

    }
    // 触顶
    else if (_ball.y < _limit.top + _ball.r) {
      _ball.y = _limit.top + _ball.r;
      _ball.vY = -_ball.vY;
      _ball.color = randomRGB();
    }

    // 触右
    if (_ball.x > _limit.right - _ball.r) {
      _ball.r = _ball.r * 0.5;
      var smallBall = Ball.fromBall(_ball);
      _balls.add(smallBall);

      _ball.x = _limit.right - _ball.r;
      _ball.vX = -_ball.vX;
      _ball.color = randomRGB();
    }
    // 触左
    else if (_ball.x < _limit.left + _ball.r) {
      _ball.x = _limit.left + _ball.r;
      _ball.vX = -_ball.vX;
      _ball.color = randomRGB();
    }
  }

  Color randomRGB() {
    var random = Random();
    return Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Runner Balls'),
      ),
      body: CustomPaint(
        painter: RunBallView(context, _balls, _limit),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var ball = Ball(x: 0, y: 0, color: Colors.blue, r: 30, aX: 0.05, aY: 0.1, vX: 3, vY: 3);
          _balls.add(ball);
          controller.forward();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
