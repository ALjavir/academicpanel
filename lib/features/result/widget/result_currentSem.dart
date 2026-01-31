import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/controller/result/result_controller.dart';
import 'package:academicpanel/theme/template/animation/Expandable_Page_View.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        spacing: 10,
        children: [
          ExpandablePageView(
            controller: controller,
            itemCount: listCurrentSemResultData.length,
            itemBuilder: (context, pageIndex) {
              final currentExams = examList[pageIndex];
              if (currentExams.isEmpty) {
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
                        "No exam for now, relax!",
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
                      spacing: 10,
                      children: [
                        Image.asset(
                          ImageStyle.assessment(),
                          scale: 20,
                          color: ColorStyle.red,
                        ),
                        Text(
                          pageIndex == 0 ? "Mid -Term Exam" : "Final Exam",
                          style: Fontstyle.defult(
                            22,
                            FontWeight.w600,
                            ColorStyle.Textblue,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: ColorStyle.red),
                    ListView.builder(
                      padding: const EdgeInsets.all(6),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentExams.length,

                      itemBuilder: (context, listIndex) {
                        final rowAssessmentModel =
                            currentExams[listIndex].rowAssessmentModel;
                        final rowCourseModel =
                            currentExams[listIndex].rowCourseModel;
                        final isLast = listIndex == currentExams.length - 1;

                        return IntrinsicHeight(
                          child: Row(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              DotlineTemplate(isLast: isLast, index: listIndex),

                              // Content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 6,
                                  children: [
                                    Text(
                                      "${rowCourseModel.name.capitalizeFirst!} - (${rowCourseModel.code})",
                                      style: Fontstyle.defult(
                                        15.5,
                                        FontWeight.w600,
                                        ColorStyle.Textblue,
                                      ),
                                    ),

                                    Row(
                                      spacing: 4,
                                      children: [
                                        const Icon(
                                          Icons.watch_later_outlined,
                                          color: ColorStyle.red,
                                          size: 18,
                                        ),

                                        Text(
                                          "${DatetimeStyle.formatTime12Hour(rowAssessmentModel.startTime, context)} - ${DatetimeStyle.formatTime12Hour(rowAssessmentModel.endTime, context)}",
                                          style: Fontstyle.defult(
                                            14,
                                            FontWeight.w600,
                                            ColorStyle.Textblue,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      spacing: 4,
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: ColorStyle.red,
                                          size: 20,
                                        ),

                                        Text(
                                          rowAssessmentModel.room,
                                          style: Fontstyle.defult(
                                            14,
                                            FontWeight.w600,
                                            ColorStyle.Textblue,
                                          ),
                                        ),

                                        const SizedBox(width: 12),
                                        const Icon(
                                          Icons.person_outline,
                                          color: ColorStyle.red,
                                          size: 20,
                                        ),
                                        Text(
                                          rowAssessmentModel.instructor[0],
                                          style: Fontstyle.defult(
                                            14,
                                            FontWeight.w600,
                                            ColorStyle.Textblue,
                                          ),
                                        ),
                                        Text(
                                          '•',
                                          style: Fontstyle.defult(
                                            14,
                                            FontWeight.normal,
                                            ColorStyle.red,
                                          ),
                                        ),
                                        Text(
                                          rowAssessmentModel.instructor[1],
                                          style: Fontstyle.defult(
                                            14,
                                            FontWeight.w600,
                                            ColorStyle.Textblue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                              showFullInfoAssessment(
                                assessmentModel: currentExams[listIndex],
                                context: context,
                                showNormalDate: true,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(examList.length, (i) {
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
}
