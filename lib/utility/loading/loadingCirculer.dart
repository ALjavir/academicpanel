import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingCirculer extends StatelessWidget {
  const LoadingCirculer({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 2,
      child: LottieBuilder.asset(
        ImageStyle.loading(),
        frameRate: FrameRate.max,
        fit: BoxFit.contain,
      ),
    );
  }
}
