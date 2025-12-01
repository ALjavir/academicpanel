import 'dart:ui';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/src/painting/text_style.dart';

class Fontstyle {
  static TextStyle splashS(double fontSize) {
    return TextStyle(
      fontFamily: 'PlayfairDisplay',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: ColorStyle.blue,
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

  static TextStyle auth(double fontSize, FontWeight fontweight, Color color) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize,
      color: color,
      fontWeight: fontweight,
      decoration: TextDecoration.none,
    );
  }
}
