import 'dart:ui';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class Fontstyle {
  static TextStyle splashS(double fontSize) {
    return GoogleFonts.playfairDisplay(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: ColorStyle.blue,
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

  static TextStyle auth(double fontSize, FontWeight fontweight, Color color) {
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
