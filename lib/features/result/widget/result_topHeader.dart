import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threeD_containerHead.dart';
import 'package:flutter/material.dart';

class ResultTopheader extends StatelessWidget {
  const ResultTopheader({super.key});

  @override
  Widget build(BuildContext context) {
    return ThreedContainerhead(
      padding: EdgeInsets.fromLTRB(10, 60, 10, 30),
      imagePath: ImageStyle.resultTopBackground(),
    );
  }
}
