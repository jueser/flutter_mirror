import 'package:flutter/material.dart';
import 'package:rpi_center/Room.dart';
import 'package:rpi_center/styles/box_decoration.dart';
import 'package:rpi_center/styles/font_style.dart';

class ItemRoom extends StatefulWidget {
  final String name;
  final image;
  final icon;
  double width = 100;
  double height = 100;
  bool cardOpen = false;

  ItemRoom({this.name, this.icon, this.image});

  @override
  _ItemRoomState createState() => _ItemRoomState();
}

class _ItemRoomState extends State<ItemRoom> {
  void expnadYouSelf(value) {
    setState(() {
      widget.cardOpen = !value;
      if (widget.cardOpen) {
        widget.width = 400;
        widget.width = 400;
      } else {
        widget.width = 200;
        widget.width = 200;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: borderedCardStyle.copyWith(
          image: DecorationImage(
            image: widget.image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: IconButton(
                icon: Icon(Icons.exposure_sharp),
                onPressed: () {
                  expnadYouSelf(widget.cardOpen);
                },
              ),
            ),
            if (widget.name != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Room(),
                    Text(
                      '${widget.name}',
                      style: TextStyleDefault,
                    ),
                  ],
                ),
              ),
            if (widget.icon != null)
              Center(
                child: Icon(
                  Icons.add,
                  size: 60,
                  color: Colors.white24,
                ),
              )
          ],
        ),
      ),
    );
  }
}
