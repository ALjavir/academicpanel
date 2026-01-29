import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threeD_containerHead.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ResultTopheader extends StatelessWidget {
  final ResultPageController resultPageController;
  const ResultTopheader({super.key, required this.resultPageController});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<UserController>();
    final rowCgpaModel = resultPageController.rowCgpaModelData;
    final double cgpaProgress = rowCgpaModel.current_cgpa / 4.0;
    final double improvement =
        rowCgpaModel.current_cgpa - rowCgpaModel.pervious_cgpa;
    final bool isPositive = improvement >= 0;
    final double completedPercent =
        rowCgpaModel.credit_completed / rowCgpaModel.target_credit;
    final double enrolledPercent =
        rowCgpaModel.credit_enrolled / rowCgpaModel.target_credit;

    return ThreedContainerhead(
      imagePath: ImageStyle.resultTopBackground(),
      padding: EdgeInsets.fromLTRB(10, 40, 10, 30),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "${rowCgpaModel.comment}  ",
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                isPositive
                                    ? Icons.arrow_upward_rounded
                                    : Icons.arrow_downward_rounded,
                                color: Colors.red,
                                size: 16,
                              ),
                            ),
                            TextSpan(
                              text: "Current CGPA",
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
                              text: "${rowCgpaModel.current_cgpa}",
                              style: Fontstyle.defult(
                                18,
                                FontWeight.w600,
                                ColorStyle.light,
                              ),
                            ),
                            TextSpan(
                              text: " / 4.00",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          Image.asset(
                            rowCgpaModel.current_cgpa >
                                    rowCgpaModel.pervious_cgpa
                                ? ImageStyle.cgpaUpIcon()
                                : ImageStyle.cgpaDownIcon(),
                            scale: 24,
                            color: Colors.red,
                          ),

                          Text(
                            "+${improvement.toStringAsFixed(2)}",
                            style: Fontstyle.defult(
                              18,
                              FontWeight.w600,
                              ColorStyle.light,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "from last sem",
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

              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearPercentIndicator(
                  animationDuration: 1000,
                  animation: true,
                  curve: Curves.easeOut,
                  percent: cgpaProgress,

                  lineHeight: 15,
                  barRadius: const Radius.circular(10),
                  progressBorderColor: ColorStyle.red,
                  backgroundColor: Colors.white24,
                  center: Text(
                    "${(cgpaProgress * 100).toStringAsFixed(1)}%",
                    style: Fontstyle.defult(11, FontWeight.w700, Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Divider(color: Colors.grey, height: 1),
              const SizedBox(height: 24),

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
                                  text: "${rowCgpaModel.credit_completed}",
                                  style: Fontstyle.defult(
                                    18,
                                    FontWeight.w600,
                                    ColorStyle.light,
                                  ),
                                ),
                                TextSpan(
                                  text: " / ${rowCgpaModel.target_credit}",
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

              const SizedBox(height: 20),

              Stack(
                alignment: Alignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 55.0,
                    lineWidth: 8.0,
                    percent: completedPercent,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: const Color(0xff1F51FF),
                    backgroundColor: Colors.white24,
                  ),

                  CircularPercentIndicator(
                    radius: 55.0,
                    lineWidth: 8.0,
                    percent: enrolledPercent,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: const Color(0xffFF5F1F),
                    backgroundColor: Colors.transparent,
                    startAngle: completedPercent * 360,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${((completedPercent + enrolledPercent) * 100).toInt()}%",
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
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
