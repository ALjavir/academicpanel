import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ResulttopheaderCgpa extends StatelessWidget {
  final ResultPageController resultPageController;
  const ResulttopheaderCgpa({super.key, required this.resultPageController});
  @override
  Widget build(BuildContext context) {
    final rowCgpaModel = resultPageController.rowCgpaModelData;
    final double cgpaProgress = rowCgpaModel.value!.current_cgpa / 4.0;
    final double improvement =
        rowCgpaModel.value!.current_cgpa - rowCgpaModel.value!.pervious_cgpa;
    final bool isPositive = improvement >= 0;

    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${rowCgpaModel.value!.comment}  ",
                style: Fontstyle.defult(18, FontWeight.w600, ColorStyle.light),
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
                            text: "${rowCgpaModel.value!.current_cgpa}",
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
                          rowCgpaModel.value!.current_cgpa >
                                  rowCgpaModel.value!.pervious_cgpa
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
            LinearPercentIndicator(
              animationDuration: 1000,
              animation: true,
              curve: Curves.easeOut,
              percent: cgpaProgress,

              lineHeight: 15,
              barRadius: const Radius.circular(10),
              progressBorderColor: ColorStyle.red,
              backgroundColor: const Color.fromARGB(60, 99, 91, 91),
              center: Text(
                "${(cgpaProgress * 100).toStringAsFixed(1)}%",
                style: Fontstyle.defult(11, FontWeight.w700, Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
