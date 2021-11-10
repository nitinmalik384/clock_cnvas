import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,

        child: ClockView(),
      ),
    );
  }
}

class ClockView extends StatefulWidget {


  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Transform.rotate(
        angle: -pi/2,

        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}


class ClockPainter extends CustomPainter {
  var datetime=DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX=size.width/2;
    var centerY=size.height/2;
    var center=Offset(centerX, centerY);
    var radius=min(centerX,centerY);

    var fillBrush=Paint()
    // ..color=Color(0xff444974);
    ..color=Color(0xff000);

    var outlineBrush=Paint()
    //..color=Color(0xffeaecff)
      ..color=Color(0xffeaecff)
      ..style=PaintingStyle.stroke
    ..strokeWidth=16;

    var centerBrush=Paint()
    ..color=Color(0xffeaecff);

    var secHandBrush=Paint()
      ..color=Colors.orange[300]
      ..style=PaintingStyle.stroke
      ..strokeCap=StrokeCap.round
      ..strokeWidth=8;

    var minHandBrush=Paint()
      ..shader=RadialGradient(colors: [Colors.lightBlue,Colors.pink]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style=PaintingStyle.stroke
      ..strokeCap=StrokeCap.round
      ..strokeWidth=12;

    var hourHandBrush=Paint()
      ..shader=RadialGradient(colors: [Colors.pink,Colors.pink[100]]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style=PaintingStyle.stroke
      ..strokeCap=StrokeCap.round
      ..strokeWidth=16;


    canvas.drawCircle(center, radius-40, fillBrush);
    canvas.drawCircle(center, radius-40, outlineBrush);





    var hourHandX=centerX+60*cos((datetime.hour*30+datetime.minute*0.5)*pi/180);
    var hourHandY=centerX+60*cos((datetime.hour*30+datetime.minute*0.5)*pi/180);
    canvas.drawLine(center,Offset(hourHandX,hourHandY),hourHandBrush);

    var minHandX=centerX+80*cos(datetime.minute *6*pi/180);
    var minHandY=centerX+80*sin(datetime.minute *6*pi/180);

    canvas.drawLine(center,Offset(minHandX,minHandY),minHandBrush);

    var secHandX=centerX+80*cos(datetime.second *6 *pi/180);
    var secHandY=centerX+80*sin(datetime.second *6*pi/180);

    canvas.drawLine(center,Offset(secHandX,secHandY),secHandBrush);
    canvas.drawCircle(center, 16, centerBrush);

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 10;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
    // var x1 = centerX + outerCircleRadius * cos(datetime.second%60*6 * pi / 180);
    // var y1 = centerX + outerCircleRadius * sin(datetime.second%60*6 * pi / 180);
    //
    // var x2 = centerX + innerCircleRadius * cos(datetime.second%60*6 * pi / 180);
    // var y2 = centerX + innerCircleRadius * sin(datetime.second%60*6 * pi / 180);
    //canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
