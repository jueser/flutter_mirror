import 'package:flutter/material.dart';

BoxDecoration borderedCardStyle = BoxDecoration(
  borderRadius: BorderRadius.circular(5.0),
  color: Color.fromRGBO(31, 42, 53, 1),
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(31, 42, 53, 1),
      Colors.black,
      Color.fromRGBO(31, 42, 53, 1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  border: Border.all(
    color: Colors.white,
    width: 0.3,
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.white.withOpacity(0.1),
      spreadRadius: 1,
      blurRadius: 2,
      offset: Offset(1, 2), // changes position of shadow
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 2,
      offset: Offset(2, 2), // changes position of shadow
    ),
  ],
);
