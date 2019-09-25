import 'package:flutter/material.dart';

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with TickerProviderStateMixin {
  Animation _scaleAnimation;
  AnimationController _scaleController;

  Animation _alphaAnimation;
  AnimationController _alphaController;

  @override
  void initState() {
    _scaleController = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this);
    Tween<double> _tween = Tween<double>(begin: 50.0, end: 150.0);
    _scaleAnimation = _tween.animate(_scaleController);
    _scaleAnimation.addListener(() {
      setState(() {});
    });

    _scaleAnimation.addStatusListener((status) {
      print("scale ----- $status");
    });

    _alphaController = AnimationController(vsync: this,duration: Duration(seconds: 1));
    _alphaAnimation = Tween<double>(begin: 0.0,end: 1.0).animate(_alphaController)
    ..addListener((){
      setState(() {

      });
    })
    ..addStatusListener((status){
      print("alpha ----- $status");
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimationDemo"),
      ),
      body: ListView(
        children: <Widget>[
          scale(),
          alpha(),
        ],
      ),
    );
  }
/// 淡入淡出
  Widget alpha() {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          child: Center(
            child: Container(
              height: 100,
              width: 100,
              child: Opacity(
                opacity: _alphaAnimation.value,
                child: FlutterLogo(),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "淡入",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _alphaController.forward();
              },
            ),
            RaisedButton(
              color: Colors.red,
              child: Text(
                "淡出",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _alphaController.reverse();
              },
            )
          ],
        ),
      ],
    );
  }

  ///放大缩小动画
  Widget scale() {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          child: Center(
            child: Container(
              width: _scaleAnimation.value,
              height: _scaleAnimation.value,
              child: new FlutterLogo(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "放大",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _scaleController.forward();
              },
            ),
            RaisedButton(
              color: Colors.red,
              child: Text(
                "缩小",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _scaleController.reverse();
              },
            )
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _alphaController.dispose();
    super.dispose();
  }
}
