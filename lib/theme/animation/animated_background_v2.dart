import 'dart:ui';

import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

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
          child: Container(
            // The "White Tint"
            // Adjust opacity to make it more white (0.6) or more transparent (0.1)
            color: Colors.white30,
          ),
        ),
        // BlurHash(
        //   hash: "L4O43i~qIU9F~q-;M{9F?bM{ofM{",
        //   optimizationMode: BlurHashOptimizationMode.approximation,
        // ),

        // LAYER 3: Your Content
        RepaintBoundary(child: widget.child),
      ],
    );
  }
}
