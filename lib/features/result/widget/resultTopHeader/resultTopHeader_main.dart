import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/features/result/widget/resultTopHeader/resultTopHeader_cgpa.dart';
import 'package:academicpanel/features/result/widget/resultTopHeader/result_topHeader_Cr.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
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
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      "${resultPageController.rowCgpaModelData.value!.comment}  ",
                  style: Fontstyle.defult(
                    18,
                    FontWeight.w600,
                    ColorStyle.light,
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.bottom,
                  child: Transform.rotate(
                    angle: -0.5,
                    child: const Icon(Icons.send, color: Colors.red, size: 26),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          ResulttopheaderCgpa(resultPageController: resultPageController),

          const Divider(color: Colors.grey, height: 1),

          ResultTopheaderCr(resultPageController: resultPageController),
        ],
      ),
    );
  }
}
