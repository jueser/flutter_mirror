import 'package:flutter/material.dart';
import 'package:rpi_center/styles/box_decoration.dart';

import 'clock_dashboard.dart';
import 'events_view.dart';

class ClockCard extends StatelessWidget {
  const ClockCard({Key key, this.controller}) : super(key: key);
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: borderedCardStyle,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              height: double.infinity,
              child: EventsView(controller),
            ),
          ),
          Flexible(
            flex: 1,
            child: ClockDashboard(),
          ),
        ],
      ),
    );
  }
}
