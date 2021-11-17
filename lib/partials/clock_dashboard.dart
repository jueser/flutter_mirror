import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.height / 100 * 25,
      height: MediaQuery.of(context).size.height / 100 * 25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 100 * 25 - 30,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: AnalogClock(
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.white),
                    color: Color.fromARGB(100, 55, 55, 55),
                    shape: BoxShape.circle),
                width: 150.0,
                isLive: true,
                hourHandColor: Colors.white,
                minuteHandColor: Colors.white,
                showSecondHand: true,
                numberColor: Colors.white,
                showNumbers: true,
                textScaleFactor: 2.4,
                showTicks: true,
                showDigitalClock: true,
                digitalClockColor: Color.fromARGB(100, 250, 250, 250),
                datetime: DateTime.now(), //DateTime(2020, 1, 1, 9, 12, 15),
              ),
            ),
          ),
          Text(
            DateFormat.yMMMMd('de_DE').format(DateTime.now()).toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w100,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
  }
}
