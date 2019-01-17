import 'package:flutter/material.dart';
import 'view/star_view.dart';
// import 'page/animated_page.dart';
import 'page/run_ball_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RunBallPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Color> _colors = const [Colors.green, Colors.blue, Colors.yellow, Colors.red, Colors.orange, Colors.purple, Colors.cyan];

  Color color;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    color = _colors[_index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: false,
        child: CustomPaint(
          painter: StarView(context, color)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _index++;
          _index = _index % _colors.length;
          this.setState(() {
            color = _colors[_index];
          });
        },
        child: Icon(Icons.add),
        backgroundColor: color,
      ),
    );
  }
}
