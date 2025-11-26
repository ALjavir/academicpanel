import 'dart:ui';

import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';

void errorSnackBar(
  BuildContext context, {
  required String title,
  String? subtitle,
  Object? e,
  required String iconName,
  required Color color1,
  required Color color2,
}) {
  final snackBar = SnackBar(
    duration: Duration(seconds: 5),
    backgroundColor: Colors.black54,
    content: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 1,
        children: [
          Row(
            children: [
              Image.asset(iconName, scale: 14, color: color1),
              SizedBox(width: 10),
              Text(
                title,
                style: Fontstyle.errorSnackBar(22, color1, FontWeight.bold),
              ),
            ],
          ),
          Text(
            (subtitle == null || subtitle.isEmpty)
                ? (e?.toString() ?? 'Unknown error')
                : subtitle,
            style: Fontstyle.errorSnackBar(20, color2, FontWeight.normal),
          ),
        ],
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
