import 'dart:ui';

import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';

class AnimatedBackgroundV2 extends StatefulWidget {
  final Widget child;
  const AnimatedBackgroundV2({super.key, required this.child});

  @override
  State<AnimatedBackgroundV2> createState() => _AnimatedBackgroundV2State();
}

class _AnimatedBackgroundV2State extends State<AnimatedBackgroundV2> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          ImageStyle.backGroundImage(),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ), // Higher sigma = frostier
        ),

        // LAYER 3: Your Content
        RepaintBoundary(child: widget.child),
      ],
    );
  }
}
