import 'dart:math' as math;

import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';

class AnimationTheme extends StatefulWidget {
  final Widget child;

  const AnimationTheme({super.key, required this.child});

  @override
  State<AnimationTheme> createState() => _AnimationThemeState();
}

class _AnimationThemeState extends State<AnimationTheme>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Speed of the loop
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
            const double radius = 1.5;

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
                    Color(0xFFcad0ff),
                    Color(0xFFe3e3e3),
                    // Color(0xFF03001e),
                    // Color(0xFF7303c0),
                    // Color(0xFFec38bc),
                    // Color(0xFFfdeff9),
                    // AnimationColorStyle.softBlue,
                    // AnimationColorStyle.glassWhite,
                    // AnimationColorStyle.softRed,
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
        Container(color: AnimationColorStyle.glassWhite),

        // LAYER 3: Content (Optimized)
        RepaintBoundary(child: widget.child),
      ],
    );
  }
}
