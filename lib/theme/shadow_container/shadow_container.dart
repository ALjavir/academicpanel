import 'package:flutter/material.dart';

class ShadowContainer extends StatefulWidget {
  final Widget child;
  const ShadowContainer({super.key, required this.child});

  @override
  State<ShadowContainer> createState() => _ShadowContainerState();
}

class _ShadowContainerState extends State<ShadowContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        // 1. Surface Color: Changed from transparent to semi-transparent
        // so it looks like glass but still has "body" to cast a shadow.
        color: Colors.transparent,

        // 2. Border Color: Added this per your request
        border: Border.all(
          color: Colors.white, // A nice frosted border color
          width: 1, // Thickness of the border
        ),

        // 3. Shape
        borderRadius: BorderRadius.circular(
          16,
        ), // Increased slightly for a smoother look
        // 4. Elevation (Shadows)
        boxShadow: [
          // Shadow for depth (The "Elevation")
          BoxShadow(
            color: Colors.black12, // Darker shadow for contrast
            blurRadius: 15, // Softens the shadow
            spreadRadius: 1,
            offset: const Offset(0, 8), // Moves shadow down to simulate height
          ),

          // Optional: Inner glow for extra "Glass" effect
        ],
      ),
      // Added child for context
      child: const Center(child: Text("My Card")),
    );
  }
}
