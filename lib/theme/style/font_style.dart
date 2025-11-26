import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class Fontstyle {
  static TextStyle splashS(double fontSize, Color color) {
    return GoogleFonts.playfairDisplay(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      decoration: TextDecoration.none,
    );
  }

  static TextStyle errorSnackBar(
    double fontSize,
    Color color,
    FontWeight fontweight,
  ) {
    return GoogleFonts.rosarivo(
      textStyle: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontweight,
      ),
      decoration: TextDecoration.none,
    );
  }
}
