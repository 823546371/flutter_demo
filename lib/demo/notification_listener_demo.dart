import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class NotificationListenerDemo extends StatefulWidget {
  @override
  _NotificationListenerDemo createState() => _NotificationListenerDemo();
}

class _NotificationListenerDemo extends State<NotificationListenerDemo> {
  final int DEFAULT_SCROLLER = 300;
  double toolbarOpacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.depth == 0) {
                  double t = notification.metrics.pixels / DEFAULT_SCROLLER;
                  if (t < 0.0) {
                    t = 0.0;
                  } else if (t > 1.0) {
                    t = 1.0;
                  }
                  setState(() {
                    toolbarOpacity = t;
                  });

                  print(notification.metrics.pixels); //打印滚动位置
                }
                return true;
              },
              child: ListView.builder(
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
                    "NotificationListenerDemo",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
