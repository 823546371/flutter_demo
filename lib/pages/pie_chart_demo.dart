import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/base_pie_entity.dart';
import 'package:flutter_demo/ui/chart_pie.dart';

class PieChartDemo extends StatefulWidget {
  @override
  _PieChartDemoState createState() => _PieChartDemoState();
}

class _PieChartDemoState extends State<PieChartDemo> {
  List<PieData> datas = List();

  @override
  void initState() {
    datas
      ..add(PieData("Java", 100.0, Colors.red))
      ..add(PieData("C++", 80.0, Colors.blue))
      ..add(PieData("Python", 90.0, Colors.purple))
      ..add(PieData("C", 75.0, Colors.green))
      ..add(PieData("JS", 95.0, Colors.amber))
      ..add(PieData("R", 50.0, Colors.teal));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PieChartDemo"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: PieChart(datas),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          setState(() {
            datas.add(PieData("New", 70, Colors.green));
          });
        },
      ),
    );
  }
}

class PieData extends BasePieEntity {
  final String title;
  final double data;
  final Color color;

  PieData(this.title, this.data, this.color);

  @override
  Color getColor() {
    return color;
  }

  @override
  double getData() {
    return data;
  }

  @override
  String getTitle() {
    return title;
  }
}
