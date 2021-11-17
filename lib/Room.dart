import 'package:flutter/material.dart';
import 'package:rpi_center/partials/light.dart';

class Room extends StatefulWidget {
  @override
  _RoomState createState() => _RoomState();
  List lights = [];
  List blinds = [];
  List sockets = [];
}

class _RoomState extends State<Room> {
  String fieldName;

  void _setOn() {}
  void _setOff() {}

  void _addLightItem({name, defaultValue}) {
    setState(() {
      widget.lights.add(Light());
    });
  }

  void _removeLightItem(index) {
    setState(() {
      widget.lights.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Light(),
        Text('Licht'),
        Container(
          height: 100,
          width: 300,
          child: ListView.builder(
            itemCount: widget.lights.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${widget.lights[index].name}'),
                subtitle: Row(
                  children: [
                    widget.lights[index],
                    GestureDetector(
                      child: Text('-'),
                      onTap: (() {
                        this._removeLightItem(index);
                      }),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        GestureDetector(
          child: Text('+'),
          onTap: (() {
            this._addLightItem();
          }),
        ),
      ],
    );
  }
}
