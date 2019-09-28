import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ScrollerDemo extends StatefulWidget {
  @override
  _ScrollerDemoState createState() => _ScrollerDemoState();
}

class _ScrollerDemoState extends State<ScrollerDemo> {
  final int DEFAULT_SCROLLER = 300;
  final int DEFAULT_SHOW_TOP_BTN = 1000;
  double toolbarOpacity = 0.0;
  ScrollController _controller = new ScrollController();

  bool showToTopBtn = false;

  @override
  void initState() {
    _controller.addListener(() {
      double t = _controller.offset / DEFAULT_SCROLLER;
      if (t < 0.0) {
        t = 0.0;
      } else if (t > 1.0) {
        t = 1.0;
      }
      setState(() {
        toolbarOpacity = t;
      });

      if(_controller.offset < DEFAULT_SHOW_TOP_BTN && showToTopBtn){
        setState(() {
          showToTopBtn = false;
        });
      }else if(_controller.offset >= DEFAULT_SHOW_TOP_BTN && !showToTopBtn){
        setState(() {
          showToTopBtn = true;
        });
      }

      print(_controller.offset); //打印滚动位置
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
              controller: _controller,
              itemCount: 100,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: 200,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return new Image.network(
                          "http://via.placeholder.com/350x150",
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: 3,
                      autoplay: true,
                      pagination: new SwiperPagination(),
                    ),
                  );
                }
                return ListTile(
                  title: Text("ListTile:$index"),
                );
              },
            ),
          ),
          Opacity(
            opacity: toolbarOpacity,
            child: Container(
              height: 98,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                  child: Text(
                    "ScrollerDemo",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.keyboard_arrow_up),
              onPressed: () {
                _controller.animateTo(0.0, duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
            ),
    );
  }
}
