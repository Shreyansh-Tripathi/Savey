import 'package:flutter/material.dart';

class ColorConstants {
  static const primaryColor = Color(0xff2D2C79);
  static const yellowColor = Colors.yellow;
  static const redColor = Colors.red;
  static const greenColor = Colors.green;
  static const cardBlue = Color(0xFF256DEA);
  static const white = Colors.white;
  static const offWhite = Color.fromARGB(255, 209, 209, 209);
  static const black = Colors.black;
  static const colorsList = [
    Color(0xff2671F3),
    Color(0xffFF5733),
    primaryColor,
    Color(0xff581845),
    Color(0xffFAC91E),
    Color(0xfffffafa),
    Color(0xff27DCC2),
  ];

  static const appTextTheme = TextTheme(
    displayLarge: TextStyle(
      color: white,
      fontWeight: FontWeight.bold,
      fontSize: 40,
    ),
    displayMedium: TextStyle(
      color: white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    displaySmall: TextStyle(
      color: white,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
    bodyMedium: TextStyle(
      color: white,
      fontWeight: FontWeight.normal,
      fontSize: 20,
    ),
    bodySmall: TextStyle(
      color: black,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
  );
}
