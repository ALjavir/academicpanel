import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';

class DotlineTemplate extends StatelessWidget {
  final bool isLast;
  final int index;

  const DotlineTemplate({super.key, required this.isLast, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Icon(
            Icons.radio_button_checked_rounded,
            size: 14,
            color: ColorStyle.red,
          ),
        ),
        if (!isLast)
          Expanded(child: Container(width: 1.5, color: Colors.grey.shade300)),
        // if (showLastDot == true)
        //   Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 4),
        //     child: Icon(Icons., size: 14, color: ColorStyle.red),
        //   ),
      ],
    );
  }
}
