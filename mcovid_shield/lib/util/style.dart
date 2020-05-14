import 'package:flutter/material.dart';

class MyColors {
  static Color primary = Colors.teal[900],
      red = Colors.deepOrangeAccent[700],
      black = Colors.black,
      white = Colors.white,
      grey = Colors.grey,
      lightBlue = Colors.deepOrangeAccent,
      lighterBlue = Colors.green,
      indicators = Colors.green;
}


class CustomClipPath extends CustomClipper<Path> {
  var radius=10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height),
        radius: Radius.elliptical(30, 10));
    path.lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
