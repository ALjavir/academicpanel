import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/normal/assessment_template.dart';
import 'package:flutter/material.dart';

class HomeAssessment extends StatelessWidget {
  final List<AssessmentModel> assessment;
  const HomeAssessment({super.key, required this.assessment});

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
                ImageStyle.reminderIcon(),
                color: ColorStyle.red,
                scale: 19,
              ),
              Text(
                "Reminder",
                style: Fontstyle.defult(
                  22,
                  FontWeight.w600,
                  ColorStyle.Textblue,
                ),
              ),
            ],
          ),
          Divider(color: ColorStyle.red),
          if (assessment.isEmpty)
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
            AssessmentTemplate(assessment: assessment),
        ],
      ),
    );
  }
}
