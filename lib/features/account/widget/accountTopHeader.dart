import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threeD_containerHead.dart';
import 'package:flutter/material.dart';

class Accounttopheader extends StatelessWidget {
  const Accounttopheader({super.key});

  @override
  Widget build(BuildContext context) {
    return ThreedContainerhead(imagePath: ImageStyle.accountTopBackground());
  }
}
