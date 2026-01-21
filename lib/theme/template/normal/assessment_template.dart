import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/hybridDate_style.dart';
import 'package:flutter/material.dart';

class AssessmentTemplate extends StatelessWidget {
  final List<AssessmentModel> assessment;
  const AssessmentTemplate({super.key, required this.assessment});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(6),
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Keeps it stable inside your Dashboard
      itemCount: assessment.length,
      itemBuilder: (context, index) {
        final item = assessment[index];
        final isLast = index == assessment.length - 1;

        return IntrinsicHeight(
          child: Row(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //spacing: 4,
                children: [
                  Baseline(
                    baseline: 16,
                    baselineType: TextBaseline.alphabetic,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: ColorStyle.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (!isLast)
                    Expanded(
                      child: Container(width: 1.5, color: Colors.grey.shade300),
                    ),
                ],
              ),

              //const SizedBox(width: 8),

              // MIDDLE: Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.assessment,
                      maxLines: 2,
                      style: Fontstyle.defult(
                        16, // 👈 MUST match baseline value above
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
                    const SizedBox(height: 18),
                  ],
                ),
              ),

              // RIGHT: Time badge
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
                  HybriddateStyle.getHybridDate(item.startTime),
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
    );
  }
}
