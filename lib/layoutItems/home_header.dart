import 'package:flutter/material.dart';
import 'package:rpi_center/partials/clock_dashboard.dart';
import 'package:rpi_center/partials/controllGlobalStateView.dart';
import 'package:rpi_center/styles/box_decoration.dart';

class MainHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: controllGlobalStateView(),
        ),
        Container(
          decoration: borderedCardStyle,
          child: Row(
            children: [
              Column(
                children: [
                  // EventsView(),
                ],
              ),
              Column(
                children: [
                  ClockDashboard(),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
