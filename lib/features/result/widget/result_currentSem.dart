import 'dart:math' as math;
import 'dart:ui';

import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/model/pages/result_Page_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_assessment_mark.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/Expandable_Page_View.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/template/normal/dotLine_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:lottie/lottie.dart';

class ResultCurrentsem extends StatefulWidget {
  final ResultPageController resultPageController;
  const ResultCurrentsem({super.key, required this.resultPageController});

  @override
  State<ResultCurrentsem> createState() => _ResultCurrentsemState();
}

class _ResultCurrentsemState extends State<ResultCurrentsem> {
  PageController controller = PageController();

  double currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listCurrentSemResultData =
        widget.resultPageController.listCurrentSemResultData;
    if (listCurrentSemResultData.isEmpty) {
      return ThreeDContainel(
        redious: 10,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRect(
              child: SizedBox(
                height: 120,
                width: double.maxFinite,
                child: Transform.scale(
                  scale: 2,
                  child: LottieBuilder.asset(
                    ImageStyle.upCommingClassaAimatedIcon(),
                    frameRate: FrameRate.max,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Text(
              "sorry No Data Found!!!",
              style: Fontstyle.defult(18, FontWeight.bold, ColorStyle.Textblue),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    } else
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          spacing: 10,
          children: [
            ExpandablePageView(
              controller: controller,
              itemCount: listCurrentSemResultData.length,
              itemBuilder: (context, pageIndex) {
                final currentResult = listCurrentSemResultData[pageIndex];
                if (currentResult.assignmentList.isEmpty &&
                    currentResult.quizList.isEmpty &&
                    currentResult.viva.mark == 0 &&
                    currentResult.presentation.mark == 0 &&
                    currentResult.midE.mark == 0 &&
                    currentResult.finalE.mark == 0) {
                  return ThreeDContainel(
                    redious: 10,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Image.asset(
                              ImageStyle.assessment(),
                              scale: 20,
                              color: ColorStyle.red,
                            ),
                            Text(
                              " ${currentResult.rowCourseModel.name}",
                              style: Fontstyle.defult(
                                22,
                                FontWeight.w600,
                                ColorStyle.Textblue,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: ColorStyle.red),
                        ClipRect(
                          child: SizedBox(
                            height: 120,
                            width: double.maxFinite,
                            child: Transform.scale(
                              scale: 2,
                              child: LottieBuilder.asset(
                                ImageStyle.upCommingClassaAimatedIcon(),
                                frameRate: FrameRate.max,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "No Result Found!!!",
                          style: Fontstyle.defult(
                            18,
                            FontWeight.bold,
                            ColorStyle.Textblue,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                }

                return ThreeDContainel(
                  redious: 10,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6,
                        children: [
                          Image.asset(
                            ImageStyle.assessment(),
                            scale: 22,
                            color: ColorStyle.red,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${currentResult.rowCourseModel.name}\n",
                                  style: Fontstyle.defult(
                                    16,
                                    FontWeight.w600,
                                    ColorStyle.Textblue,
                                  ),
                                ),
                                TextSpan(
                                  text: "${currentResult.rowCourseModel.code}",
                                  style: Fontstyle.defult(
                                    13,
                                    FontWeight.w600,
                                    ColorStyle.lightBlue,
                                  ),
                                ),
                                TextSpan(
                                  text: " • ",
                                  style: Fontstyle.defult(
                                    13,
                                    FontWeight.w600,
                                    ColorStyle.red,
                                  ),
                                ),

                                TextSpan(
                                  text:
                                      "${currentResult.rowCourseModel.credit} Cradit",
                                  style: Fontstyle.defult(
                                    13,
                                    FontWeight.w600,
                                    ColorStyle.lightBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: ColorStyle.red),
                      Column(
                        children: [
                          ShowData("Quiz", currentResult.quizList),
                          ShowData("Assign.", currentResult.assignmentList),
                          ShowData("Pres.", [currentResult.presentation]),
                          ShowData("Viva", [currentResult.viva]),
                          ShowData("Mid", [currentResult.midE]),
                          ShowData("Final", [currentResult.finalE]),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(listCurrentSemResultData.length, (i) {
                final active = i == currentPageValue.round();
                //  print("Listview 1: $_currentPage1");
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 12 : 8,
                  height: active ? 12 : 8,
                  decoration: BoxDecoration(
                    color: active ? ColorStyle.red : Colors.grey.shade400,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ],
        ),
      );
  }

  Widget ShowData(String title, List<RowAssessmentMark> marks) {
    // 1. Safety Check
    if (marks.isEmpty || (marks.length == 1 && marks[0].assessment == "")) {
      return const SizedBox.shrink();
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: -math.pi / 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,

                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 4,

                  itemBuilder: (context, index) {
                    return const Icon(
                      Icons.brightness_1,
                      size: 11,
                      color: Colors.red,
                    );
                  },
                ),

                Expanded(
                  child: Container(
                    width: 1.5,
                    color: Colors.grey.shade300,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: marks.map((item) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${item.assessment}: ",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: "${item.mark}",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }
}
