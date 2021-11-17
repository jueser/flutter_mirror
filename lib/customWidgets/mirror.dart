import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'carusel.dart';

class Mirror extends StatefulWidget {
  const Mirror({
    Key key,
    @required double screenHeight,
    @required double screenWidth,
    @required this.boxWidth,
    @required this.boxHeight,
    @required List item,
    double depthOfMirror = 0.42,
    Color borderColor = Colors.white,
  })  : _screenHeight = screenHeight,
        _screenWidth = screenWidth,
        _item = item,
        _depthOfMirror = depthOfMirror,
        _borderColor = borderColor,
        super(key: key);

  final double _screenHeight;
  final double _screenWidth;
  final double boxWidth;
  final double boxHeight;
  final List<Widget> _item;
  final double _depthOfMirror;
  final Color _borderColor;

  @override
  State<Mirror> createState() => _MirrorState();
}

class _MirrorState extends State<Mirror> {
  ScrollController controllerContent, controllerContentMirrored;
  LinkedScrollControllerGroup _controllers;
  Widget mainView, mainViewMirrored, customListView;
  List vewBoxes = [];
  final scrollController = ScrollController();
  List characters;
  final itemSize = 300.0;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    controllerContent = _controllers.addAndGet();
    controllerContentMirrored = _controllers.addAndGet();
    characters = widget._item;
    scrollController.addListener(onListen);
  }

  void onListen() {
    setState(() {});
  }

  void setVisibiliti() {
    int index = 0;
    for (var i in widget._item) {
      this.vewBoxes.add(index);
      this.vewBoxes[index] = 1.0;
      index++;
    }
  }

  void _createListViews(List content) {
    this.customListView = MyScener(
      contentList: content,
    );

    /*CustomScrollView(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final heightFactor = 1.0;
              final character = characters[index];
              final itemPositionOffset = index * itemSize * heightFactor;
              print(scrollController.position);
              final difference = scrollController.offset - itemPositionOffset;
              final percent = 1.0 - (difference / (itemSize * heightFactor));
              double opacity = percent;
              double scale = percent;
              if (opacity > 1.0) opacity = 1.0;
              if (opacity < 0.0) opacity = 0.0;
              if (percent > 1.0) scale = 1.0;
              if (percent < 0.2) scale = 0.2;

              return Align(
                heightFactor: heightFactor,
                child: Opacity(
                  opacity: opacity,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(scale, scale),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: character,
                    ),
                  ),
                ),
              );
            },
            childCount: characters.length,
          ),
        ),
      ],
    );*/
    this.mainView = ListView.builder(
      controller: controllerContent,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: content.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: VisibilityDetector(
            key: Key(index.toString()),
            onVisibilityChanged: (visibilityInfo) {
              var visiblePercentage = visibilityInfo.visibleFraction;

              this.vewBoxes[index] = visiblePercentage;

              //content[index]['scale'] = visiblePercentage;
              print(
                  'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
            },
            child: Transform.scale(
              scale: this.vewBoxes[index],
              child: content[index],
            ),
          ),
        );
      },
    );
    this.mainViewMirrored = ListView.builder(
      controller: controllerContentMirrored,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: content.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: content[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _createListViews(widget._item);
    setVisibiliti();
    double mirrorPosition =
        widget._screenHeight - (widget._screenHeight * widget._depthOfMirror);
    double boxPositionY = (widget._screenHeight / 2) - widget.boxHeight;
    double boxPositionX = (widget._screenWidth - widget.boxWidth) / 2;

    return Stack(
      children: [
        // gespiegelter Inhalt
        Positioned(
          top: mirrorPosition,
          left: 0, // boxPositionX,
          child: Opacity(
            opacity: 0.45,
            child: Transform(
              origin: Offset(
                  0, -widget.boxHeight / 2 + widget._screenHeight * 0.02),
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(3.2),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: widget._screenWidth,
                height: widget.boxHeight,
                child: this.customListView, //this.mainViewMirrored,
              ),
            ),
          ),
        ),

        // Schadow over mirred container
        Positioned(
          top: mirrorPosition,
          child: Container(
            width: (widget._screenWidth),
            height: widget._screenHeight / 2 * 1.1,
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 0.6, color: widget._borderColor)),
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
          top: boxPositionY,
          child: Padding(
            padding: EdgeInsets.only(
              left: 0, //boxPositionX
            ),
            child: SizedBox(
              width: widget._screenWidth,
              height: widget.boxHeight,
              child: this.customListView, //this.mainView,
            ),
          ),
        ),
      ],
    );
  }
}
