import 'package:flutter/material.dart';
import 'package:rpi_center/partials/room.dart';

class RoomsLine extends StatelessWidget {
  final List<Map> rooms = [
    {
      'name': 'Wohnzimmer',
      'image': AssetImage('assets/images/appBarBG.jpg'),
    },
    {
      'name': 'Küche',
      'image': AssetImage('assets/images/appBarBG.jpg'),
    },
    {
      'name': 'Flur',
      'image': AssetImage('assets/images/appBarBG.jpg'),
    },
    {
      'name': 'Gäste-WC',
      'image': AssetImage('assets/images/appBarBG.jpg'),
    },
    {
      'name': 'Schlafzimmer',
      'image': AssetImage('assets/images/appBarBG.jpg'),
    },
    {
      'name': 'Victorias Zimmer',
      'image': AssetImage('assets/images/appBarBG.jpg'),
    },
    {
      'name': 'Erikszimmer',
      'image': AssetImage('assets/images/appBarBG.jpg'),
    },
    {
      'name': null,
      'image': AssetImage('assets/images/appBarBG.jpg'),
      'icon': Icon(Icons.add),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.01 * 30,
      child: Center(
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            return ItemRoom(
              name: rooms[index]['name'],
              image: rooms[index]['image'],
              icon: rooms[index]['icon'],
            );
          },
        ),
      ),
    );
  }
}
