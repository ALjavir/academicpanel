import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultTopheaderCr extends StatelessWidget {
  final ResultPageController resultPageController;
  const ResultTopheaderCr({super.key, required this.resultPageController});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<UserController>();
    final rowCgpaModel = resultPageController.rowCgpaModelData;

    final double completedPercent =
        rowCgpaModel.value!.credit_completed /
        rowCgpaModel.value!.target_credit;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 4,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.check_circle_outline_outlined,
                              color: Colors.red,
                              size: 15,
                            ),
                          ),
                          TextSpan(
                            text: " Credit Completed",
                            style: Fontstyle.defult(
                              13,
                              FontWeight.bold,
                              ColorStyle.light,
                            ),
                          ),
                        ],
                      ),
                    ),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${rowCgpaModel.value!.credit_completed}",
                            style: Fontstyle.defult(
                              18,
                              FontWeight.w600,
                              ColorStyle.light,
                            ),
                          ),
                          TextSpan(
                            text: " / ${rowCgpaModel.value!.target_credit}",
                            style: Fontstyle.defult(
                              18,
                              FontWeight.w500,
                              Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.school_rounded,
                          color: Colors.red,
                          size: 22,
                        ),
                      ),
                      TextSpan(
                        text:
                            " ${DateFormat('MMM, y').format(user.user.value!.last_semester!)}",
                        style: Fontstyle.defult(
                          18,
                          FontWeight.w600,
                          ColorStyle.light,
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  "Estimated last sem",
                  style: Fontstyle.defult(
                    13,
                    FontWeight.bold,
                    ColorStyle.light,
                  ),
                ),
              ],
            ),
          ],
        ),

        Center(
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(90),
            ),
            child: CircularPercentIndicator(
              animationDuration: 1000,
              animation: true,
              radius: 55.0,
              lineWidth: 8.0,
              percent: completedPercent,
              progressColor: ColorStyle.pgCircleBarColor1,
              backgroundWidth: 1.5,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(completedPercent * 100).toInt()}%",
                    style: Fontstyle.defult(
                      18,
                      FontWeight.w600,
                      ColorStyle.light,
                    ),
                  ),
                  Text(
                    "Done",
                    style: Fontstyle.defult(
                      13,
                      FontWeight.bold,
                      ColorStyle.light,
                    ),
                  ),
                ],
              ),

              backgroundColor: ColorStyle.pgCircleBarColor2,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ),
        ),
      ],
    );
  }
}
