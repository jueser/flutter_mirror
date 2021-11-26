import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

var onSelectCard = ValueNotifier<int>(0);

class CardData {
  Color color;
  double x, y, z, angle;
  final int idx;
  double alpha = 0;
  Widget contentItem;

  CardData(this.idx, contentList) {
    contentItem = contentList[idx];
    color = Colors.primaries[idx % Colors.primaries.length];
    x = 0;
    y = 0;
    z = 0;
  }
}

class ReflectedScreen extends StatefulWidget {
  final List<Widget> contentList;
  ReflectedScreen({
    Key key,
    @required this.contentList,
  }) : super(key: key);

  @override
  _ReflectedScreenState createState() => _ReflectedScreenState();
}

class _ReflectedScreenState extends State<ReflectedScreen>
    with TickerProviderStateMixin {
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
    radioStep = (pi * 2) / widget.contentList.length;
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
    radio = MediaQuery.of(context).size.width / 5; // Radius
    var initAngleOffset = pi / 2 + (-_dragX * .006);
    initAngleOffset += selectedAngle;

    // process positions.
    for (var i = 0; i < cardData.length; ++i) {
      var c = cardData[i];
      double ang = initAngleOffset + c.idx * radioStep;
      c.angle = ang + pi / 2;
      c.x = cos(ang) * radio * 1.5; // Radius
      c.y = sin(ang) * -40; // Till of eclipse
      c.z = sin(ang) * radio;
    }

    // sort in Z axis.
    cardData.sort((a, b) => a.z.compareTo(b.z));

    var list = cardData.map((vo) {
      var c = addCard(vo);
      var mt2 = Matrix4.identity();
      mt2.setEntry(3, 2, 0.001);
      mt2.translate(vo.x, vo.y, -vo.z); // Position right/left/scale
      // mt2.rotateY(vo.angle + pi); //Card rotation
      c = Transform(
        alignment: Alignment.center,
        origin: Offset(0, -100 + _scaleController.value),
        transform: mt2,
        child: c,
      );

      // depth of field... doesnt work on web.
      // var blur = .4 + ((1 - vo.z / radio) / 2) * 2;
      // c = BackdropFilter(
      //  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      //   child: c,
      //);

      return c;
    }).toList();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (e) {
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 200, //MediaQuery.of(context).size.height / 2.2,
            child: Transform(
              origin: Offset(0, 0),
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(3.2),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Stack(
                  alignment: Alignment.center,
                  children: list,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(width: 0.6, color: Colors.white)),
                color: Colors.white,
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(31, 42, 53, 0.2),
                    Color.fromRGBO(31, 42, 53, 0.85),
                    Color.fromRGBO(51, 62, 73, 1),
                    Color.fromRGBO(51, 62, 73, 1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3.5,
            child: Stack(
              alignment: Alignment.center,
              children: list,
            ),
          ),
        ],
      ),
    );
  }

  Widget addCard(CardData vo) {
    Widget c;
    c = Stack(children: [
      Positioned(
        child: Container(
          // TODO: breite höhe berechnen/parametrisieren
          width: 350,
          height: 220,
          alignment: Alignment.center,
          child: vo.contentItem,
        ),
      ),
      // Spiegelung über Item
      Positioned(
        child: Opacity(
          opacity: 0.15,
          child: Container(
            width: 350,
            height: 220,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.5 - vo.x * 0.001, 0.5 - vo.x * 0.001],
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(85, 255, 255, 255),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
    return c;
  }
}
