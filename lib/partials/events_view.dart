import 'package:flutter/material.dart';
import 'package:rpi_center/styles/font_style.dart';

class EventsView extends StatelessWidget {
  final ScrollController controller;
  EventsView(this.controller);
  final List<Map> events = [
    {
      'title': 'Gelbe Säcke',
      'icon': Icons.access_alarm,
      'datum': '21.11.2020',
    },
    {
      'title': 'Geburtstag Victoria',
      'icon': Icons.accessibility_outlined,
      'datum': '06.08.2021',
    },
    {
      'title': 'Geburtstag Erik',
      'icon': Icons.accessibility_outlined,
      'datum': '01.06.2021',
    },
    {
      'title': 'Geburtstag Erik',
      'icon': Icons.accessibility_outlined,
      'datum': '01.06.2021',
    },
    {
      'title': 'Geburtstag Erik',
      'icon': Icons.accessibility_outlined,
      'datum': '01.06.2021',
    },
    {
      'title': 'Geburtstag Erik',
      'icon': Icons.accessibility_outlined,
      'datum': '01.06.2021',
    },
    {
      'title': 'Geburtstag Erik',
      'icon': Icons.accessibility_outlined,
      'datum': '01.06.2021',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        controller: controller,
        scrollDirection: Axis.vertical,
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsetsDirectional.only(start: 5),
            title: Row(
              children: [
                Icon(
                  events[index]['icon'],
                  size: 25,
                  color: Colors.white70,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${events[index]['title']}',
                        style: TextStyleDefault.copyWith(fontSize: 12),
                      ),
                      Text(
                        '${events[index]['datum']}',
                        style: TextStyleDefault.copyWith(
                            fontSize: 12, color: Colors.white60),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
