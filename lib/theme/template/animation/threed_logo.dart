import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThreeDLogo extends StatelessWidget {
  final String assetName;
  final double height;

  const ThreeDLogo({super.key, required this.assetName, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // LAYER 1: The Shadow (The "3D" Depth)
        Transform.translate(
          offset: const Offset(8, 10), // Moves shadow down-right
          filterQuality: FilterQuality.high,
          transformHitTests: true,
          child: ImageFiltered(
            // Blurs the black logo to make it look like a shadow
            imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: SvgPicture.asset(
              assetName,
              height: height,
              // Forces the logo to be Black + Transparent
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(30, 0, 0, 0),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),

        // LAYER 2: The Actual Logo
        SvgPicture.asset(assetName, height: height),
      ],
    );
  }
}
