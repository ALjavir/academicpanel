import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class AnimationBackground extends StatefulWidget {
  final Widget child;

  const AnimationBackground({super.key, required this.child});

  @override
  State<AnimationBackground> createState() => _AnimationBackgroundState();
}

class _AnimationBackgroundState extends State<AnimationBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0), // Speed of the loop
    )..repeat(); // NO REVERSE. Just repeat 0 -> 1 continuously.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // LAYER 1: The Moving Gradient
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final double angle = _controller.value * 2 * math.pi;

            // --- THE CIRCLE MATH ---
            // We create a circle using Sin and Cos.
            // Radius = 1.0 means it touches the edges of the screen.
            // Radius > 1.0 means the color center is slightly off-screen (softer look).
            const double radius = 3;

            // Point 1 (Blue) orbits the center
            final Alignment startAlign = Alignment(
              math.cos(angle) * radius,
              math.sin(angle) * radius,
            );

            // Point 2 (Red) is exactly opposite (PI radians away)
            // This ensures they are always chasing each other across the center
            final Alignment endAlign = Alignment(
              math.cos(angle + math.pi) * radius,
              math.sin(angle + math.pi) * radius,
            );
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [
                    // ColorStyle.light,
                    // ColorStyle.light,
                    // Colors.black12,
                    // Colors.white12,
                    Color(0xFF1e3f76),
                    Colors.white,
                    Color(0xFFa8302f),
                    //  Color(0xFFf2f3e2),
                    //   Color.fromARGB(10, 19, 70, 125),
                    //ColorStyle.light,
                    // Color.fromARGB(10, 159, 27, 25),
                  ],
                  // As these values swap, the colors physically travel across the screen
                  begin: startAlign,
                  end: endAlign,
                ),
              ),
            );
          },
        ),

        // LAYER 2: The "Fake Glass" Overlay
        // Keeps the text readable and adds that "Frosted" feel without lag

        // LAYER 3: Content (Optimized)
        RepaintBoundary(child: widget.child),
      ],
    );
  }
}
