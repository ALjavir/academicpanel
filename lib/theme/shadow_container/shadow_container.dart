import 'package:flutter/material.dart';

class ShadowContainer extends StatefulWidget {
  final Widget child;
  final double height;
  const ShadowContainer({super.key, required this.child, required this.height});

  @override
  State<ShadowContainer> createState() => _ShadowContainerState();
}

class _ShadowContainerState extends State<ShadowContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * widget.height,
      decoration: BoxDecoration(
        color: const Color.fromARGB(150, 255, 255, 255),
        border: Border.all(color: Colors.white10, width: 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          "Glass Card",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF13467D), // Using your Deep Blue for contrast
          ),
        ),
      ),
    );
  }
}
