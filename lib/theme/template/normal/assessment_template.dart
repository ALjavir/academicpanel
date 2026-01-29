import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/template/normal/dotLine_template.dart';
import 'package:academicpanel/theme/template/normal/showDialogAssessment_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

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
        final rowAssessmentModel = assessment[index].rowAssessmentModel;
        final rowCourseModel = assessment[index].rowCourseModel;
        final isLast = index == assessment.length - 1;

        return IntrinsicHeight(
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DotlineTemplate(isLast: isLast, index: index),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rowAssessmentModel.assessment.capitalizeFirst!,
                      maxLines: 2,

                      style: Fontstyle.defult(
                        16,
                        FontWeight.w600,

                        ColorStyle.Textblue,
                      ),
                    ),
                    Text(
                      "${rowCourseModel.name.capitalizeFirst!} (${rowCourseModel.code})",
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
              openLink(assessmentModel: assessment[index], context: context),

              // InkWell(
              //   onTap: () {
              //     showDialogAssessment(context, assessment[index]);
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 10,
              //       vertical: 4,
              //     ),
              //     decoration: BoxDecoration(
              //       color: ColorStyle.red,
              //       borderRadius: BorderRadius.circular(12),

              //       boxShadow: [
              //         BoxShadow(
              //           blurRadius: 1,
              //           color: Colors.black26,
              //           offset: Offset(0.5, 1),
              //           spreadRadius: 0.5,
              //         ),
              //       ],
              //     ),
              //     child: Text(
              //       "${DatetimeStyle.getHybridDate(rowAssessmentModel.startTime)} ->",
              //       style: Fontstyle.defult(
              //         10,
              //         FontWeight.w600,
              //         ColorStyle.light,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
