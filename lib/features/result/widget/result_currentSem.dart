import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/resultSuperModel/row_assessment_mark.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/Expandable_Page_View.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              "No data found...",
              style: Fontstyle.defult(18, FontWeight.w500, ColorStyle.Textblue),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    } else
      return Column(
        spacing: 10,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.58,
            child: ExpandablePageView(
              controller: controller,
              itemCount: listCurrentSemResultData.length,
              itemBuilder: (context, pageIndex) {
                final currentResult = listCurrentSemResultData[pageIndex];

                List<String> title = [
                  "Quiz",
                  "Assign",
                  "Pres",
                  "Viva",
                  "Mid",
                  "Final",
                ];
                List<List<RowAssessmentMark>> incomingMarks = [
                  currentResult.quizList,
                  currentResult.assignmentList,
                  currentResult.presentationList,
                  currentResult.vivaList,
                  [currentResult.midE],
                  [currentResult.finalE],
                ];

                if (currentResult.assignmentList.isEmpty &&
                    currentResult.quizList.isEmpty &&
                    currentResult.vivaList.isEmpty &&
                    currentResult.presentationList.isEmpty &&
                    currentResult.midE.mark == 0 &&
                    currentResult.finalE.mark == 0)
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
                              ImageStyle.sunject(),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Divider(color: ColorStyle.red),
                        ),
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
                          "No result found...",
                          style: Fontstyle.defult(
                            18,
                            FontWeight.w500,
                            ColorStyle.Textblue,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                else
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ThreeDContainel(
                      redious: 10,

                      padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
                      child: Column(
                        spacing: 4,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 6,
                            children: [
                              Image.asset(
                                ImageStyle.sunject(),
                                scale: 22,
                                color: ColorStyle.red,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 2,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      "${currentResult.rowCourseModel.name.capitalizeFirst}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: Fontstyle.defult(
                                        18,
                                        FontWeight.w600,
                                        ColorStyle.Textblue,
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "${currentResult.rowCourseModel.code}",
                                          style: Fontstyle.defult(
                                            12,
                                            FontWeight.w500,
                                            ColorStyle.Textblue,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " • ",
                                          style: Fontstyle.defult(
                                            12,
                                            FontWeight.w600,
                                            ColorStyle.red,
                                          ),
                                        ),

                                        TextSpan(
                                          text:
                                              "${currentResult.rowCourseModel.credit} Cr.",
                                          style: Fontstyle.defult(
                                            12,
                                            FontWeight.w500,
                                            ColorStyle.Textblue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Divider(color: ColorStyle.red),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            itemCount: title.length,
                            itemBuilder: (context, index) {
                              final isLast = index == title.length - 1;
                              return showData(
                                title[index],
                                incomingMarks[index],
                                isLast,
                                index,
                              );
                            },
                          ),
                          // Column(
                          //   children: [
                          //     showData("Quiz", currentResult.quizList),
                          //     showData("Assign.", currentResult.assignmentList),
                          //     showData("Pres.", currentResult.presentationList),
                          //     showData("Viva", currentResult.vivaList),
                          //     showData("Mid", [currentResult.midE]),
                          //     showData("Final", [currentResult.finalE]),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  );
              },
            ),
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
      );
  }

  Widget showData(
    String title,
    List<RowAssessmentMark?>? incomingMarks,
    bool isLast,
    Index,
  ) {
    final List<RowAssessmentMark> marks =
        incomingMarks?.whereType<RowAssessmentMark>().toList() ?? [];

    final bool noItem =
        marks.isEmpty || (marks.length == 1 && marks.first.assessment == "");
    final bool isMidtermOrFinal =
        title.toLowerCase().startsWith("m") ||
        title.toLowerCase().startsWith("f");

    final String currentUserId = widget.userController.user.value?.id ?? "";

    Widget buildChip(RowAssessmentMark item) {
      final bool isTBA = item.score.toInt().toString() == currentUserId;

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
            ),
          ],
        ),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: isTBA ? "TBA / " : "${item.score} / ",
                style: Fontstyle.defult(
                  13,
                  FontWeight.w600,
                  ColorStyle.Textblue,
                ),
              ),
              TextSpan(
                text: item.mark.toString(),
                style: Fontstyle.defult(
                  12,
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
          // ================== 1. TITLE ==================
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: RotatedBox(
              quarterTurns: -1,
              child: Text(
                title,
                style: Fontstyle.defult(
                  15,
                  FontWeight.w600,
                  noItem ? ColorStyle.lightBlue : ColorStyle.Textblue,
                ),
              ),
            ),
          ),

          // ================== 2. TIMELINE LINE ==================
          //DotlineTemplate(isLast: false, index: Index, showLastDot: isLast),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.radio_button_checked_rounded,
                size: 12,
                color: ColorStyle.red,
              ),
              Expanded(
                child: Container(
                  width: 1.5,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                ),
              ),
              // Cleaned up the 'SizedBox.shrink()' ternary
              // if (isLast)
              //   Icon(
              //     Icons.radio_button_checked_rounded,
              //     size: 12,
              //     color: ColorStyle.red,
              //   ),
            ],
          ),

          // ================== 3. DYNAMIC CONTENT AREA ==================
          Expanded(
            child: Builder(
              builder: (context) {
                if (noItem) {
                  // SCENARIO A: No items found
                  return SizedBox(
                    //color: Colors.amber,
                    height: 60,
                    child: Center(
                      child: Text(
                        "N/A",
                        style: Fontstyle.defult(
                          15,
                          FontWeight.w500,
                          ColorStyle.lightBlue,
                        ),
                      ),
                    ),
                  );
                }

                if (isMidtermOrFinal) {
                  // SCENARIO B: Midterm or Final (Show only the first chip)
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(children: [buildChip(marks.first)]),
                  );
                }

                // SCENARIO C: Everything else (Show the scrollable list of chips)
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SizedBox(
                    height: 35,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: marks.length,
                      separatorBuilder: (c, i) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return Row(
                          spacing: 8,
                          children: [
                            buildChip(marks[index]),
                            if (index < marks.length - 1)
                              Icon(
                                Icons.brightness_1,
                                size: 7,
                                color: ColorStyle.red,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
