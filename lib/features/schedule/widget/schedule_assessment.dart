import 'package:academicpanel/controller/page/schedule_page_contoller.dart';
import 'package:academicpanel/theme/animation/threed_containel.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/hybridDate_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';

class ScheduleAssessment extends StatefulWidget {
  final SchedulePageContoller schedulePageContoller;
  const ScheduleAssessment({super.key, required this.schedulePageContoller});

  @override
  State<ScheduleAssessment> createState() => _ScheduleAssessmentState();
}

class _ScheduleAssessmentState extends State<ScheduleAssessment> {
  @override
  Widget build(BuildContext context) {
    return ThreeDContainel(
      padding: EdgeInsets.all(10),
      redious: 10,
      child: Column(
        children: [
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Image.asset(
                ImageStyle.assessment(),
                color: ColorStyle.red,
                scale: 19,
              ),
              Text(
                "Assessments",
                style: Fontstyle.defult(
                  22,
                  FontWeight.w600,
                  ColorStyle.Textblue,
                ),
              ),
            ],
          ),
          Divider(color: ColorStyle.red),
          if (widget.schedulePageContoller.assessmentschedule.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "No reminder yet!!!",
                  style: Fontstyle.defult(18, FontWeight.w600, ColorStyle.red),
                ),
              ),
            )
          else
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.schedulePageContoller.assessmentschedule.length,
              itemBuilder: (context, index) {
                final item =
                    widget.schedulePageContoller.assessmentschedule[index];
                final isLast =
                    index ==
                    widget.schedulePageContoller.assessmentschedule.length - 1;

                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Container(
                              width: 12,
                              height: 12,
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

                      // --- MIDDLE SECTION: Content ---
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            // Title (Message)
                            Text(
                              item.assessment,
                              maxLines: 2,
                              softWrap: true,
                              style: Fontstyle.defult(
                                16,
                                FontWeight.w600,
                                ColorStyle.Textblue,
                              ),
                            ),

                            Text(
                              "${item.rowCourseModel.name} (${item.rowCourseModel.code})",
                              style: Fontstyle.defult(
                                12,
                                FontWeight.w500,
                                ColorStyle.lightBlue,
                              ),
                            ),

                            const SizedBox(height: 16),
                          ],
                        ),
                      ),

                      // --- RIGHT SECTION: Time Badge ---
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
                          HybriddateStyle.getHybridDate(item.date),
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
  }
}
