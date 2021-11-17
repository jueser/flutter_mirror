import 'package:flutter/material.dart';
import 'package:rpi_center/styles/box_decoration.dart';
import 'package:rpi_center/styles/font_style.dart';

class controllGlobalStateView extends StatefulWidget {
  @override
  _controllGlobalStateViewState createState() =>
      _controllGlobalStateViewState();
}

class _controllGlobalStateViewState extends State<controllGlobalStateView> {
  bool isSwitchedGreen = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Haus Verlassen?',
          style: TextStyleDefault,
        ),
        Row(
          children: [
            Icon(
              Icons.house_outlined,
              size: 120,
              color: Colors.white54,
            ),
            Icon(
              Icons.arrow_forward,
              size: 60,
              color: Colors.white54,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Licht',
              style: TextStyleDefault.copyWith(
                letterSpacing: 4.0,
              ),
            ),
            Switch(
              activeColor: Colors.white,
              inactiveThumbColor: Colors.black,
              value: isSwitchedGreen,
              onChanged: (value) {
                setState(() {
                  isSwitchedGreen = value;
                  //_testLed(3, value);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Jalousien',
                style: TextStyleDefault.copyWith(
                  letterSpacing: 4.0,
                ),
              ),
            ),
            Switch(
              value: isSwitchedGreen,
              onChanged: (value) {
                setState(() {
                  isSwitchedGreen = value;
                  //_testLed(3, value);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Aussenbeleuchtung',
                style: TextStyleDefault.copyWith(
                  letterSpacing: 4.0,
                ),
              ),
            ),
            Switch(
              value: isSwitchedGreen,
              onChanged: (value) {
                setState(() {
                  isSwitchedGreen = value;
                  //_testLed(3, value);
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
