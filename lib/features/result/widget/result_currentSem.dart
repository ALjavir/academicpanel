import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
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
  final UserController userController;
  const ResultCurrentsem({
    super.key,
    required this.resultPageController,
    required this.userController,
  });

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
                  padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
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
                          showData("Quiz", currentResult.quizList),
                          showData("Assign.", currentResult.assignmentList),
                          showData("Pres.", [currentResult.presentation]),
                          showData("Viva", [currentResult.viva]),
                          showData("Mid", [currentResult.midE]),
                          showData("Final", [currentResult.finalE]),
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

  Widget showData(String title, List<RowAssessmentMark?>? incomingMarks) {
    final List<RowAssessmentMark> marks =
        incomingMarks?.whereType<RowAssessmentMark>().toList() ?? [];

    if (marks.isEmpty || (marks.length == 1 && marks[0].assessment == "")) {
      return const SizedBox.shrink();
    }

    // Helper function to create the UI for a single mark (DRY Principle)
    Widget _buildChip(RowAssessmentMark item) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorStyle.light,

          border: Border.all(color: Colors.black12, width: 1),

          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurStyle: BlurStyle.outer,
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text:
                    item.score.toInt().toString() ==
                        widget.userController.user.value!.id
                    ? "TBA / "
                    : "${item.score} / ",
                style: Fontstyle.defult(
                  13,
                  FontWeight.w600,
                  ColorStyle.Textblue,
                ),
              ),

              TextSpan(
                text: item.mark.toString(),
                style: Fontstyle.defult(
                  13,
                  FontWeight.w600,
                  ColorStyle.lightBlue,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return IntrinsicHeight(
      child: Row(
        spacing: 2,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. TITLE
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: RotatedBox(
              quarterTurns: -1,
              child: Text(
                title,
                style: Fontstyle.defult(
                  16,
                  FontWeight.w600,
                  ColorStyle.Textblue,
                ),
              ),
            ),
          ),

          // 2. LINE
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const Icon(Icons.brightness_1, size: 11, color: ColorStyle.red),
              Expanded(
                child: Container(
                  width: 1.5,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                ),
              ),
            ],
          ),

          const SizedBox(width: 0),

          Expanded(
            child:
                (title.toLowerCase().startsWith("q") ||
                    title.toLowerCase().startsWith("a"))
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 35,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: marks.length,
                        separatorBuilder: (c, i) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              spacing: 8,
                              children: [
                                _buildChip(marks[index]),
                                if (index < marks.length - 1)
                                  Icon(
                                    Icons.brightness_1,
                                    size: 7,
                                    color: ColorStyle.red,
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(children: [_buildChip(marks[0])]),
                  ),
          ),
        ],
      ),
    );
  }
}
