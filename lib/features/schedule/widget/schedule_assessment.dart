import 'package:academicpanel/controller/page/schedule_page_contoller.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/template/normal/assessment_template.dart';
import 'package:academicpanel/theme/template/normal/dropdownbutton_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ScheduleAssessment extends StatefulWidget {
  final SchedulePageContoller schedulePageContoller;
  const ScheduleAssessment({super.key, required this.schedulePageContoller});

  @override
  State<ScheduleAssessment> createState() => _ScheduleAssessmentState();
}

class _ScheduleAssessmentState extends State<ScheduleAssessment> {
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
                Text(
                  "Assessments",
                  style: Fontstyle.defult(
                    22,
                    FontWeight.w600,
                    ColorStyle.Textblue,
                  ),
                ),
                DropdownbuttonTemplate(
                  onChanged: (value) async {
                    // print(
                    //   "the selected value/////////////////////////////////////: $value",
                    // );
                    await widget.schedulePageContoller.fetchAssessment(
                      sortBy: value!,
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

              if (data.assessmentModel.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "No reminder yet!!!",
                      style: Fontstyle.defult(
                        18,
                        FontWeight.w600,
                        ColorStyle.red,
                      ),
                    ),
                  ),
                );
              } else {
                // 3. Render the List (No need for a second Obx inside here)
                return AssessmentTemplate(assessment: data.assessmentModel);
              }
            }),
          ],
        ),
      ),
    );
  }
}
