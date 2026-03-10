import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';

class DotlineTemplate extends StatelessWidget {
  final bool isLast;
  final int index;
  final bool? showLastDot;
  const DotlineTemplate({
    super.key,
    required this.isLast,
    required this.index,
    this.showLastDot,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child:
              //  Icon(
              //   Icons.brightness_1_outlined,
              //   size: 14,
              //   color: ColorStyle.red,
              // ),
              Container(
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                  color: ColorStyle.light,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorStyle.red, width: 1.5),
                ),
              ),
        ),
        if (!isLast)
          Expanded(child: Container(width: 1.5, color: Colors.grey.shade300)),
        if (showLastDot == true)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                color: ColorStyle.light,
                shape: BoxShape.circle,
                border: Border.all(color: ColorStyle.red, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}
