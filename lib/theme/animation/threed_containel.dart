import 'package:flutter/material.dart';

class ThreeDContainel extends StatefulWidget {
  final Widget child;
  final double? hight;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double redious;
  final BoxConstraints? boxConstraints;

  const ThreeDContainel({
    super.key,
    required this.child,
    this.hight,
    this.width,
    this.padding,
    required this.redious,
    this.boxConstraints,
  });

  @override
  State<ThreeDContainel> createState() => _ThreeDContainelState();
}

class _ThreeDContainelState extends State<ThreeDContainel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.hight,
      width: widget.hight,
      padding: widget.padding,
      constraints: widget.boxConstraints,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.redious),
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurStyle: BlurStyle.outer,
            blurRadius: 6,
            // offset: Offset(2, 4), // Softness
            spreadRadius: 1,
          ),
        ],
        // border: Border.all(
        //   color: const Color.fromARGB(16, 0, 0, 0),
        //   width: 1.5,
        // ),
      ),
      child: widget.child,
    );
  }
}
