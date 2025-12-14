import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiagonalReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const DiagonalReveal({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<DiagonalReveal> createState() => _DiagonalRevealState();
}

class _DiagonalRevealState extends State<DiagonalReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    // START DELAY: Wait 500ms for the page transition to finish settling
    // before starting the wiper animation. This creates a smoother feel.
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // MATH LOGIC:
        // We want the gradient to start "off screen" (-0.3) and move to "full" (1.0).
        // 1.3 is the total distance it needs to travel (0.3 offset + 1.0 width).
        double val = (_controller.value * 1.3) - 0.3;

        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // 'dstIn' mode means:
              // White = Show Image
              // Transparent = Hide Image
              colors: const [Colors.white, Colors.transparent],

              // This controls the slide.
              // [val] is where solid white ends.
              // [val + 0.3] is where transparency begins (the fade softness).
              stops: [val, val + 0.3],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: widget.child,
        );
      },
    );
  }
}

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
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SvgPicture.asset(
              assetName,
              height: height,
              // Forces the logo to be Black + Transparent
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(38, 0, 0, 0),
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
