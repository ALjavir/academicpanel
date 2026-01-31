import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/features/result/widget/resultTopHeader/resultTopHeader_cgpa.dart';
import 'package:academicpanel/features/result/widget/resultTopHeader/result_topHeader_Cr.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threeD_containerHead.dart';
import 'package:flutter/material.dart';

class ResulttopheaderMain extends StatelessWidget {
  final ResultPageController resultPageController;
  const ResulttopheaderMain({super.key, required this.resultPageController});

  @override
  Widget build(BuildContext context) {
    return ThreedContainerhead(
      imagePath: ImageStyle.resultTopBackground(),
      padding: EdgeInsets.fromLTRB(10, 40, 10, 30),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResulttopheaderCgpa(resultPageController: resultPageController),

          const Divider(color: Colors.grey, height: 1),

          ResultTopheaderCr(resultPageController: resultPageController),
        ],
      ),
    );
  }
}
