// ignore_for_file: deprecated_member_use

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
          // BoxShadow(
          //   color: Colors.grey.withOpacity(0.1), // Much softer shadow
          //   spreadRadius: 1,
          //   blurRadius: 10, // Higher blur = softer look
          //   offset: Offset(0, 4),
          // ),
          // BoxShadow(
          //   color: const Color.fromARGB(8, 0, 0, 0), // Soft dark shadow
          //   blurRadius: 4,
          //   offset: Offset(4, 4), // Softness
          //   spreadRadius: 2,
          // ),
          BoxShadow(
            color: Colors.grey.shade300,
            blurStyle: BlurStyle.outer,
            blurRadius: 10,
            //offset: Offset(2, 4),
            spreadRadius: 0,
          ),
        ],
        // border: Border.all(color: Color.fromARGB(16, 0, 0, 0), width: 1),
      ),
      child: widget.child,
    );
  }
}
