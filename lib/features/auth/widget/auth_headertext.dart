import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';

class AuthHeadertext extends StatefulWidget {
  final String title;
  final String subtitle;

  const AuthHeadertext({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<AuthHeadertext> createState() => _AuthHeadertextState();
}

class _AuthHeadertextState extends State<AuthHeadertext> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: Fontstyle.defult3d(
            32,
            FontWeight.bold,
            ColorStyle.Textblue,
            const Color.fromARGB(40, 19, 70, 125),
            const Offset(3, 3),
            3,
          ),
          // style: Fontstyle.auth(32, FontWeight.bold, ColorStyle.Textblue)
          //     .copyWith(
          //       shadows: [
          //         BoxShadow(
          //           color: const Color.fromARGB(40, 19, 70, 125),
          //           offset: const Offset(3, 3), // Horizontal, Vertical offset
          //           blurRadius: 3, // Softness
          //         ),
          //       ],
          //     ),
        ),

        Text(
          textAlign: TextAlign.center,
          widget.subtitle,
          style: Fontstyle.defult(14, FontWeight.w600, ColorStyle.lightBlue),
        ),
      ],
    );
  }
}
