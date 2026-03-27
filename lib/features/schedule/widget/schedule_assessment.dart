import 'package:academicpanel/controller/page/schedule_page_contoller.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/template/normal/assessmentTemp/assessment_template.dart';
import 'package:academicpanel/theme/template/normal/dropdownbutton_template.dart';
import 'package:academicpanel/utility/loading/loadingPageContent.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:lottie/lottie.dart';

class ScheduleAssessment extends StatefulWidget {
  final SchedulePageContoller schedulePageContoller;
  const ScheduleAssessment({super.key, required this.schedulePageContoller});

  @override
  State<ScheduleAssessment> createState() => _ScheduleAssessmentState();
}

class _ScheduleAssessmentState extends State<ScheduleAssessment> {
  final RxString title = "Assessments".obs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ThreeDContainel(
        padding: EdgeInsets.all(12),
        redious: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  spacing: 8,
                  children: [
                    Image.asset(
                      ImageStyle.assment(),
                      color: ColorStyle.red,
                      scale: 18,
                    ),
                    Obx(() {
                      return Text(
                        title.value.capitalizeFirst!,
                        style: Fontstyle.defult(
                          22,
                          FontWeight.w600,
                          ColorStyle.Textblue,
                        ),
                      );
                    }),
                  ],
                ),
                DropdownbuttonTemplate(
                  onChanged: (value) async {
                    // print(
                    //   "the selected value/////////////////////////////////////: $value",
                    // );
                    title.value = value!;
                    await widget.schedulePageContoller.fetchAssessment(
                      sortBy: value,
                    );
                  },
                  items: widget
                      .schedulePageContoller
                      .assessmentschedulePage
                      .value
                      .courseCode,

                  hint: 'Course',
                ),
              ],
            ),
            Divider(color: ColorStyle.red),

            // 1. Wrap the WHOLE logic in Obx
            Obx(() {
              final data =
                  widget.schedulePageContoller.assessmentschedulePage.value;
              if (widget.schedulePageContoller.isLoadingAssessment == true) {
                return Center(child: LoadingPageContent());
              } else if (data.assessmentModel.isEmpty) {
                return Column(
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "No Incomplete assessment...",
                          style: Fontstyle.defult(
                            18,
                            FontWeight.w500,
                            ColorStyle.Textblue,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return AssessmentTemplate(assessment: data.assessmentModel);
              }
            }),
          ],
        ),
      ),
    );
  }
}
