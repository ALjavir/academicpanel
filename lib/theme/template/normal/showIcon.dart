import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShowIcon extends StatelessWidget {
  final double size;
  final String imageName;
  final Color? color;
  const ShowIcon({
    super.key,
    required this.size,
    required this.imageName,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageName,
      width: size,
      height: size,
      colorFilter: const ColorFilter.mode(ColorStyle.red, BlendMode.srcIn),
    );
  }
}
