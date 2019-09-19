import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_demo/ui/base_pie_entity.dart';

class PieChart extends StatefulWidget {
  final List<BasePieEntity> data;

  PieChart(this.data);

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: CustomPaint(
        painter: PieChartPainter(widget.data),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  double radius;
  double line1;
  double line2;

  List<BasePieEntity> entities;

  Paint _paint = Paint()
    ..color = Colors.red
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..strokeWidth = 12.0;

  TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    maxLines: 1,
  );

  PieChartPainter(entities) {
    this.entities = entities;

    var total = 0.0;

    this.entities.forEach((e) {
      total += e.getData();
    });

    this.entities.forEach((e) {
      e.angle = e.getData() / total * 360;
    });

    _paint.strokeWidth = 1.0;
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width > size.height) {
      radius = size.height / 3;
    } else {
      radius = size.width / 3;
    }

    line1 = radius / 3;
    line2 = radius / 2;

    canvas.translate(size.width / 2, size.height / 2);

    Rect rect = Rect.fromLTRB(-radius, -radius, radius, radius);
    // 设置起始角度
    double currentAngle = 0.0;

    for (var i = 0; i < entities.length; i++) {
      var entity = entities[i];
      _paint.color = entity.getColor();
      canvas.drawArc(rect, (currentAngle * pi / 180), (entity.angle * pi / 180),
          true, _paint);
      _drawLineAndText(canvas, currentAngle, entity.angle, radius,
          entity.getTitle(), entity.getColor());

      currentAngle += entity.angle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawLineAndText(Canvas canvas, double currentAngle, double angle,
      double r, String name, Color color) {
    // 绘制横线
    // 1，计算开始坐标和转折点坐标
    var startX = r * (cos((currentAngle + (angle / 2)) * (pi / 180)));
    var startY = r * (sin((currentAngle + (angle / 2)) * (pi / 180)));

    var stopX = (r + line1) * (cos((currentAngle + (angle / 2)) * (pi / 180)));
    var stopY = (r + line1) * (sin((currentAngle + (angle / 2)) * (pi / 180)));

    // 2、计算坐标在左边还是在右边，并计算横线结束坐标
    var endX;
    if (stopX - startX > 0) {
      endX = stopX + line2;
    } else {
      endX = stopX - line2;
    }

    // 3、绘制斜线和横线
    canvas.drawLine(Offset(startX, startY), Offset(stopX, stopY), _paint);
    canvas.drawLine(Offset(stopX, stopY), Offset(endX, stopY), _paint);

    // 4、绘制文字
    // 绘制下方名称
    // 上下间距偏移量
    var offset = 4;
    // 1、测量文字
    var tp = _newVerticalAxisTextPainter(name, color);
    tp.layout();

    var w = tp.width;
    // 2、计算文字坐标
    var textStartX;
    if (stopX - startX > 0) {
      if (w > line2) {
        textStartX = (stopX + offset);
      } else {
        textStartX = (stopX + (line2 - w) / 2);
      }
    } else {
      if (w > line2) {
        textStartX = (stopX - offset - w);
      } else {
        textStartX = (stopX - (line2 - w) / 2 - w);
      }
    }
    tp.paint(canvas, Offset(textStartX, stopY + offset));

    // 绘制上方百分比，步骤同上
    // todo 保留2为小数，确保精准度
    var per = (angle / 360.0 * 100).toStringAsFixed(2) + "%";

    var tpPre = _newVerticalAxisTextPainter(per, color);
    tpPre.layout();

    w = tpPre.width;
    var h = tpPre.height;

    if (stopX - startX > 0) {
      if (w > line2) {
        textStartX = (stopX + offset);
      } else {
        textStartX = (stopX + (line2 - w) / 2);
      }
    } else {
      if (w > line2) {
        textStartX = (stopX - offset - w);
      } else {
        textStartX = (stopX - (line2 - w) / 2 - w);
      }
    }

    tpPre.paint(canvas, Offset(textStartX, stopY - offset - h));
  }

  // 文字画笔 风格定义
  TextPainter _newVerticalAxisTextPainter(String text, Color color) {
    return _textPainter
      ..text = TextSpan(
        text: text,
        style: new TextStyle(
          color: color,
          fontSize: 12.0,
        ),
      );
  }
}


