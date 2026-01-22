import 'package:academicpanel/controller/page/schedule_page_contoller.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/Expandable_Page_View.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ScheduleExam extends StatefulWidget {
  final SchedulePageContoller schedulePageContoller;
  const ScheduleExam({super.key, required this.schedulePageContoller});

  @override
  State<ScheduleExam> createState() => _ScheduleExamState();
}

class _ScheduleExamState extends State<ScheduleExam> {
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
    String formatTime12Hour(DateTime dateTime) {
      try {
        return TimeOfDay.fromDateTime(dateTime).format(context);
      } catch (e) {
        return '';
      }
    }

    final midExamItem = widget.schedulePageContoller.examPageSchedule.midExam;
    final finalExamItem =
        widget.schedulePageContoller.examPageSchedule.finalExam;
    final examList = [midExamItem, finalExamItem];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        spacing: 10,
        children: [
          SizedBox(
            height: 400,
            child: ExpandablePageView(
              controller: controller,

              itemCount: examList.length,
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
                        padding: EdgeInsets.all(6),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentExams.length,

                        itemBuilder: (context, listIndex) {
                          final item = currentExams[listIndex];
                          final isLast = listIndex == currentExams.length - 1;

                          return IntrinsicHeight(
                            child: Row(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 7,
                                      ),
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          color: ColorStyle.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    if (!isLast)
                                      Expanded(
                                        child: Container(
                                          width: 2,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                  ],
                                ),

                                // Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 6,
                                    children: [
                                      Text(
                                        "${item.rowCourseModel.name.capitalizeFirst!} - (${item.rowCourseModel.code})",
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
                                            "${formatTime12Hour(item.startTime)} - ${formatTime12Hour(item.endTime)}",
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
                                            item.room,
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
                                            item.instructor[0],
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
                                            item.instructor[1],
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
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorStyle.red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    DateFormat('d, MMM').format(item.startTime),
                                    style: Fontstyle.defult(
                                      10,
                                      FontWeight.w600,
                                      ColorStyle.light,
                                    ),
                                  ),
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
                  color: active ? Colors.black : Colors.grey.shade400,
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
