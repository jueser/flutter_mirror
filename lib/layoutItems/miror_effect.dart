import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:rpi_center/customWidgets/mirror.dart';
import 'package:rpi_center/partials/clock_card.dart';
import 'package:rpi_center/styles/box_decoration.dart';

class MirrorEffect extends StatefulWidget {
  const MirrorEffect({Key key}) : super(key: key);

  @override
  State<MirrorEffect> createState() => _MirrorEffectState();
}

class _MirrorEffectState extends State<MirrorEffect> {
  ScrollController controllerA, controllerB;
  LinkedScrollControllerGroup _controllers;

  static const boxWidth = 450.0;
  static const boxHeight = 320.0;
  static const scaleFactor = 1.0;
  double scaleItemFactor = 1.0;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    controllerA = _controllers.addAndGet();
    controllerB = _controllers.addAndGet();
  }

  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;

    List<Widget> content = [
      SizedBox(width: 450, height: 320, child: ClockCard()),
      SizedBox(width: 450, height: 320, child: ClockCard()),
      SizedBox(width: 450, height: 320, child: ClockCard()),
      SizedBox(width: 450, height: 320, child: ClockCard()),
      SizedBox(width: 450, height: 320, child: ClockCard()),
      SizedBox(
        width: 450,
        height: 220,
        child: Container(
          decoration: borderedCardStyle,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: double.infinity,
                  child: Text('Hallo'),
                ),
              ),
              Flexible(
                flex: 1,
                child: Text('test'),
              ),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      body: Transform.scale(
        scale: scaleFactor,
        child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(71, 82, 93, 1),
                Color.fromRGBO(255, 255, 255, 1),
              ],
            ),
          ),
          child: Center(
            child: Container(
              height: _screenHeight,
              width: _screenWidth,
              child: Mirror(
                depthOfMirror: 0.48,
                screenHeight: _screenHeight,
                screenWidth: _screenWidth,
                boxWidth: boxWidth,
                boxHeight: boxHeight,
                item: content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
