import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashsPageMain extends StatelessWidget {
  const SplashsPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          spacing: 0,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SvgPicture.asset(ImageStyle.logo()),
            Text(
              'Presidency University',
              style: Fontstyle.splashS(32, ColorStyle.blue),
            ),
          ],
        ),
      ),
    );
  }
}
