import 'dart:ui';

import 'package:flutter/material.dart';

class BlurryTypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration; // Total time for the whole word to appear
  final double blurStrength; // How blurry it starts (e.g., 10.0)

  const BlurryTypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(milliseconds: 3000),
    this.blurStrength = 5.0,
  });

  @override
  State<BlurryTypewriterText> createState() => _BlurryTypewriterTextState();
}

class _BlurryTypewriterTextState extends State<BlurryTypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _opacityAnims;
  late List<Animation<double>> _blurAnims;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    final int charCount = widget.text.length;
    // We divide the timeline so letters appear one after another
    // The "step" is how much time we wait before starting the next letter
    final double step = 0.5 / charCount;

    _opacityAnims = [];
    _blurAnims = [];

    for (int i = 0; i < charCount; i++) {
      // Each letter starts slightly later than the previous one
      final double start = i * step;
      final double end =
          start + 0.2; // Each letter takes 50% of timeline to fully animate

      // Create the Interval for this specific letter
      final interval = CurvedAnimation(
        parent: _controller,
        curve: Interval(
          start.clamp(0.0, 1.0),
          end.clamp(0.0, 1.0),
          curve: Curves.easeOut,
        ),
      );

      _opacityAnims.add(Tween<double>(begin: 0.0, end: 1.0).animate(interval));
      _blurAnims.add(
        Tween<double>(begin: widget.blurStrength, end: 0.0).animate(interval),
      );
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We split the text into characters
    final characters = widget.text.split('');

    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(characters.length, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final opacity = _opacityAnims[index].value;
            final blur = _blurAnims[index].value;

            // Optimization: If blur is 0, don't use ImageFiltered (saves GPU)
            if (blur == 0) {
              return Opacity(
                opacity: opacity,
                child: Text(characters[index], style: widget.style),
              );
            }

            return Opacity(
              opacity: opacity,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: Text(characters[index], style: widget.style),
              ),
            );
          },
        );
      }),
    );
  }
}
