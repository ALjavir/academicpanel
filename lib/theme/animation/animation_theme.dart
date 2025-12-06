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
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15), // Adjust speed of the "swap" here
    )..repeat(reverse: true); // This creates the continuous loop/cycle

    // MOVEMENT LOGIC:
    // The "Start" of the gradient (Blue) moves from Top-Left -> Bottom-Right
    _topAlignmentAnimation = Tween<Alignment>(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCirc));

    // The "End" of the gradient (Red) moves from Bottom-Right -> Top-Left
    _bottomAlignmentAnimation = Tween<Alignment>(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc));
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
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [
                    AnimationColorStyle.softBlue,
                    AnimationColorStyle.softRed,
                  ],
                  // As these values swap, the colors physically travel across the screen
                  begin: _topAlignmentAnimation.value,
                  end: _bottomAlignmentAnimation.value,
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
