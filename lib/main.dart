import 'package:flutter/material.dart';

import 'demo/animation_demo.dart';
import 'demo/notification_listener_demo.dart';
import 'demo/scroller_demo.dart';
import 'pages/pie_chart_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'CustomView Demo'),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("PieChartDemo"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PieChartDemo()));
            },
          ),
          ListTile(
            title: Text("AnimationDemo"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AnimationDemo()));
            },
          ),
          ListTile(
            title: Text("ScrollerDemo"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScrollerDemo()));
            },
          ),
          ListTile(
            title: Text("NotificationListenerDemo"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationListenerDemo()));
            },
          )
        ],
      ),
    );
  }
}


