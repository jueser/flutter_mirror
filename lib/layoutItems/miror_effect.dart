import 'package:flutter/material.dart';
import 'package:rpi_center/partials/cklock_card.dart';

class MirrorEffect extends StatefulWidget {
  const MirrorEffect({Key key}) : super(key: key);

  @override
  State<MirrorEffect> createState() => _MirrorEffectState();
}

class _MirrorEffectState extends State<MirrorEffect> {
  ScrollController controller;

  static const boxWidth = 600.0;
  static const boxHeight = 400.0;
  static const scaleFactor = 1.0;

  @override
  void initState() {
    this.controller = ScrollController();
    super.initState();
  }

  Widget build(BuildContext context) {
    Widget _item = ClockCard();
    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _boxHeight = boxHeight;
    var _positionMirror = (_screenHeight / 2) * 0.9;

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
              child: Stack(
                children: [
                  // gespiegelter Inhalt
                  Positioned(
                    top: _positionMirror - (_screenHeight * 0.05),
                    left: (_screenWidth - boxWidth) / 2,
                    child: Opacity(
                      opacity: 0.45,
                      child: Container(
                        child: Transform.translate(
                          offset: Offset(0, -260),
                          child: Transform(
                            origin: Offset(0, 0),
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(3.2),
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: boxWidth,
                              height: boxHeight,
                              child: _item,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Schadow over mirred container
                  Positioned(
                    top: _positionMirror + _positionMirror * 0.085,
                    child: Container(
                      width: (_screenWidth),
                      height: _screenHeight / 2 * 1.1,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 0.6,
                                color: Colors.white.withOpacity(0.75))),
                        color: Colors.white,
                        gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(31, 42, 53, 0.2),
                            Color.fromRGBO(31, 42, 53, 0.85),
                            //Color.fromRGBO(51, 62, 73, 1),
                            //Color.fromRGBO(51, 62, 73, 1),
                            Color.fromRGBO(51, 62, 73, 1),
                            Color.fromRGBO(51, 62, 73, 1),
                            // Color.fromRGBO(31, 42, 53, 1.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // tatsächliches Inhalt
                  Positioned(
                    top: _screenHeight / 2 - _boxHeight,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: (_screenWidth - boxWidth) / 2),
                      child: SizedBox(
                        width: boxWidth,
                        height: boxHeight,
                        child: _item,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
