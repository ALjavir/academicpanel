import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/model/resultSuperModel/row_assessment_mark.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/Expandable_Page_View.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:flutter/material.dart';
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
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Stack(
                          children: [
                            // 1. The Main Vertical Axis Line
                            Positioned(
                              left: 60,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 1.5,
                                color: Colors.blueAccent.withOpacity(0.5),
                              ),
                            ),

                            // 2. The Data Rows
                            Column(
                              children: [
                                _buildAxisRow("Quiz", currentResult.quizList),
                                _buildAxisRow(
                                  "Assign.",
                                  currentResult.assignmentList,
                                ),
                                _buildAxisRow("Pres.", [
                                  currentResult.presentation,
                                ]),
                                _buildAxisRow("Viva", [currentResult.viva]),
                                _buildAxisRow("Mid", [currentResult.midE]),
                                _buildAxisRow("Final", [currentResult.finalE]),
                              ],
                            ),
                          ],
                        ),
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

  Widget _buildAxisRow(String label, List<RowAssessmentMark> marks) {
    if (marks.isEmpty || (marks[0].assessment == ""))
      return const SizedBox.shrink();

    return SizedBox(
      height: 50,
      child: Row(
        children: [
          // Vertical Label
          SizedBox(
            width: 50,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // The Axis Node (The Red Dot)
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(left: 5, right: 15),
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
          ),

          // Horizontal Scores with Dashed Line effect
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: marks.length,
              itemBuilder: (context, index) {
                final m = marks[index];
                return Row(
                  children: [
                    // Visual "Grid" Dot
                    Text(
                      "${m.score}/${m.mark}",
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                    if (index != marks.length - 1)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: 20,
                        height: 1,
                        color: Colors.redAccent.withOpacity(
                          0.2,
                        ), // Connecting line
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
