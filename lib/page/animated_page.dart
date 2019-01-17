import 'package:flutter/material.dart';
import '../view/animated_star.dart';

class AnimatedPage extends StatefulWidget {
  @override
  _AnimatedPageState createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;
  Animation<int> intAnimation;
  Animation<Color> colorAnimation;
  double radius = 50;
  int _num = 5;
  Color _color = Colors.orange;

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
      duration: const Duration(milliseconds: 2000), vsync: this
    );

    colorAnimation = ColorTween(begin: Colors.orange, end: Colors.red).animate(controller)
      ..addListener(() {
        setState(() {
          _color = colorAnimation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
        print('status = $status');
      });

    intAnimation = IntTween(begin: 5, end: 200).animate(controller)
      ..addListener(() {
        setState(() {
          _num = intAnimation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
        print('status = $status');
      });

    // animation = new Tween(begin: 25.0, end: 100.0).animate(CurveTween(curve: Curves.bounceInOut).animate(controller))
    //   ..addListener(() {
    //     setState(() {
    //       radius = animation.value;
    //     });
    //   })
    //   ..addStatusListener((AnimationStatus status) {
    //     if (status == AnimationStatus.completed) {
    //       controller.reverse();
    //     } else if (status == AnimationStatus.dismissed) {
    //       controller.forward();
    //     }
    //     print('status = $status');
    //   });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('animated view')
      ),
      body: CustomPaint(
        painter: AnimatedStar(context, radius, _num, _color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.forward();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
