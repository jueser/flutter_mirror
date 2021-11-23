import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

int numItems = 10;
var onSelectCard = ValueNotifier<int>(0);

class CardData {
  Color color;
  double x, y, z, angle;
  final int idx;
  double alpha = 0;
  Widget contentItem;

  Color get lightColor {
    var val = HSVColor.fromColor(color);
    return val.withSaturation(.5).withValue(.8).toColor();
  }

  CardData(this.idx, contentList) {
    contentItem = contentList[idx];
    color = Colors.primaries[idx % Colors.primaries.length];
    x = 0;
    y = 0;
    z = 0;
  }
}

class MyScener extends StatefulWidget {
  final List<Widget> contentList;
  AnimationController controller;
  MyScener({Key key, @required this.contentList, @required this.controller})
      : super(key: key);

  @override
  _MyScenerState createState() => _MyScenerState();
}

class _MyScenerState extends State<MyScener> with TickerProviderStateMixin {
  AnimationController _scaleController;
  List<CardData> cardData = [];
  double radio = 200.0;
  double radioStep = 0;
  bool isMousePressed = false;
  double _dragX = 0;
  double selectedAngle = 0;
  bool animateOnPen = false;

  @override
  void initState() {
    cardData = List.generate(widget.contentList.length,
        (index) => CardData(index, widget.contentList)).toList();
    radioStep = (pi * 2) / numItems;
    _scaleController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _scaleController.addListener(() => setState(() {}));

    onSelectCard.addListener(() {
      var idx = onSelectCard.value;
      _dragX = 0;
      selectedAngle = -idx * radioStep;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //radio = MediaQuery.of(context).size.width / 3.0; // Radius
    var initAngleOffset = pi / 2 + (-_dragX * .006);
    initAngleOffset += selectedAngle;

    // process positions.
    for (var i = 0; i < cardData.length; ++i) {
      var c = cardData[i];
      double ang = initAngleOffset + c.idx * radioStep;
      c.angle = ang + pi / 2;
      c.x = cos(ang) * radio;
      c.y = sin(ang) * -30; // Till of eclipse
      c.z = sin(ang) * radio;
    }

    // sort in Z axis.
    cardData.sort((a, b) => a.z.compareTo(b.z));

    var list = cardData.map((vo) {
      var c = addCard(vo);
      var mt2 = Matrix4.identity();
      mt2.setEntry(3, 2, 0.001);
      mt2.translate(vo.x, vo.y, -vo.z);
      // mt2.rotateY(vo.angle + pi); //Card rotation
      c = Transform(
        alignment: Alignment.center,
        origin: Offset(0.0, -100 + _scaleController.value * 900.0),
        transform: mt2,
        child: c,
      );

      // depth of field... doesnt work on web.
      var blur = .4 + ((1 - vo.z / radio) / 2) * 2;
      c = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: c,
      );

      return c;
    }).toList();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (e) {
        // isMousePressed = true;
        setState(() {});
        if (animateOnPen)
          _scaleController.animateTo(1,
              duration: Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn);
      },
      onPanUpdate: (e) {
        _dragX += e.delta.dx;
        setState(() {});
      },
      onPanEnd: (e) {
        isMousePressed = false;
        _scaleController.animateTo(0,
            duration: Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn);
        setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: list,
        ),
      ),
    );
  }

  Widget addCard(CardData vo) {
    var alpha = ((1 - vo.z / radio) / 2) * .8;
    Widget c;
    c = Stack(children: [
      Positioned(
        child: Container(
          margin: EdgeInsets.all(12),
          width: 350,
          height: 220,
          alignment: Alignment.center,
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            color: Colors.black.withOpacity(alpha),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.5 - vo.x * 0.001, 0.5 - vo.x * 0.001],
              colors: [
                vo.lightColor,
                vo.color,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.2 + alpha * .2),
                  spreadRadius: 1,
                  blurRadius: 12,
                  offset: Offset(0, 2))
            ],
          ),
          child: Transform.scale(
            scale: 1,
            child: vo.contentItem,
          ),
        ),
      ),
      Positioned(
        child: Opacity(
          opacity: 0.15,
          child: Container(
            margin: EdgeInsets.all(12),
            width: 350,
            height: 220,
            alignment: Alignment.center,
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(alpha),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.5 - vo.x * 0.001, 0.5 - vo.x * 0.001],
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(85, 255, 255, 255),
                  //vo.lightColor,
                  //vo.color,
                ],
              ),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.2 + alpha * .2),
                    spreadRadius: 1,
                    blurRadius: 12,
                    offset: Offset(0, 2))
              ],
            ),
            child: Container(),
          ),
        ),
      ),
    ]);
    return GestureDetector(
      child: c,
      onTap: () => onSelectCard.value = vo.idx,
    );
  }
}

class SceneCardSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 80,
      child: Row(
        children: List.generate(
            numItems,
            (index) => Expanded(
                  child: SizedBox(
                    height: 80,
                    child: OutlinedButton(
                      child: Text(index.toString()),
                      onPressed: () => onSelectCard.value = index,
                    ),
                  ),
                )),
      ),
    );
  }
}
