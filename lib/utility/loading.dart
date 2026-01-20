import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  final double hight;
  const Loading({super.key, required this.hight});

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      ImageStyle.loading(),
      frameRate: FrameRate.max,
      height: hight,
    );
  }
}
