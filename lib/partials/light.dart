import 'package:flutter/material.dart';

class Light extends StatefulWidget {
  String name = "test";
  bool state = false;

  @override
  _LightState createState() => _LightState();
}

class _LightState extends State<Light> {
  void _switchLight(value) {
    widget.state = value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('${widget.name}'),
        Switch(
          value: widget.state,
          onChanged: (value) {
            setState(() {
              widget.state = value;
            });
          },
        ),
      ],
    );
  }
}
