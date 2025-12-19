import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';

class Fontstyle {
  static TextStyle splashS(double fontSize) {
    return TextStyle(
      fontFamily: 'PlayfairDisplay',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: ColorStyle.Textblue,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle errorSnackBar(
    double fontSize,
    Color color,
    FontWeight fontweight,
  ) {
    return TextStyle(
      fontFamily: 'Quicksand',
      fontSize: fontSize,
      color: color,
      fontWeight: fontweight,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle defult(double fontSize, FontWeight fontweight, Color color) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize,
      color: color,
      fontWeight: fontweight,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle defult3d(
    double fontSize,
    FontWeight fontweight,
    Color color,
    Color color3d,
    Offset offset,
    double blurRadius,
  ) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize,
      color: color,
      fontWeight: fontweight,
      decoration: TextDecoration.none,
      shadows: [
        BoxShadow(
          color: color3d,
          offset: offset, // Horizontal, Vertical offset
          blurRadius: blurRadius, // Softness
        ),
      ],
    );
  }
}
