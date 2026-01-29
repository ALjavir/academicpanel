import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';

class ThreedContainerhead extends StatefulWidget {
  final Widget? child;
  final double? hight;
  final double? width;
  final EdgeInsetsGeometry? padding;

  final BoxConstraints? boxConstraints;
  final String imagePath;

  const ThreedContainerhead({
    super.key,
    this.child,
    this.hight,
    this.width,
    this.padding,

    this.boxConstraints,
    required this.imagePath,
  });

  @override
  State<ThreedContainerhead> createState() => _ThreedContainerheadState();
}

class _ThreedContainerheadState extends State<ThreedContainerhead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.hight,
      width: widget.hight,
      padding: widget.padding,
      constraints: widget.boxConstraints,

      decoration: BoxDecoration(
        color: ColorStyle.glassWhite,
        image: DecorationImage(
          fit: BoxFit.cover,

          image: AssetImage(widget.imagePath),
        ),

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),

      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurStyle: BlurStyle.outer,
            blurRadius: 6,
            offset: Offset(0, -0.6),
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
