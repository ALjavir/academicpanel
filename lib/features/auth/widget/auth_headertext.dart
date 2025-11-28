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
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '${widget.title}\n',
            style: Fontstyle.auth(32, FontWeight.bold, ColorStyle.blue),
          ),
          TextSpan(
            text: widget.subtitle,
            style: Fontstyle.auth(14, FontWeight.normal, ColorStyle.lightBlue),
          ),
        ],
      ),
    );
  }
}
