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
          style: Fontstyle.auth(32, FontWeight.bold, ColorStyle.blue).copyWith(
            shadows: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(3, 3), // Horizontal, Vertical offset
                blurRadius: 5.0, // Softness
              ),
              // Optional: Add a second shadow for "Glow"
              BoxShadow(
                color: Colors.white10,
                offset: const Offset(-2, -2), // Opposite direction
                blurRadius: 5.0,
              ),
            ],
          ),
        ),

        // TextSpan(
        //   text: '${widget.title}\n',
        //   style: Fontstyle.auth(32, FontWeight.bold, ColorStyle.blue),
        // ),
        Text(
          textAlign: TextAlign.center,
          widget.subtitle,
          style: Fontstyle.auth(14, FontWeight.w600, ColorStyle.lightBlue),
        ),
      ],
    );
  }
}
