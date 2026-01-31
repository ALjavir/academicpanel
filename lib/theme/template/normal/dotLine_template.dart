import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';

class DotlineTemplate extends StatelessWidget {
  final bool isLast;
  final int index;
  const DotlineTemplate({super.key, required this.isLast, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (index == 0) const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Icon(Icons.brightness_1, size: 11, color: ColorStyle.red),
        ),
        if (!isLast)
          Expanded(child: Container(width: 1.5, color: Colors.grey.shade300)),
      ],
    );
  }
}
