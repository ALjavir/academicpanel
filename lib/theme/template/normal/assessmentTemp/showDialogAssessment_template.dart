import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/dateTime_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

Widget showFullInfoAssessment({
  bool showNormalDate = false,
  required BuildContext context,
  required AssessmentModel assessmentModel,
}) {
  return InkWell(
    onTap: () {
      showDialogAssessment(context, assessmentModel);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: ColorStyle.red,
        borderRadius: BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.black26,
            offset: Offset(0.5, 1),
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Text(
        showNormalDate
            ? "${DateFormat('d MMM').format(assessmentModel.rowAssessmentModel.startTime)} ->"
            : "${DatetimeStyle.getHybridDate(assessmentModel.rowAssessmentModel.startTime)} ->",
        style: Fontstyle.defult(10, FontWeight.w600, ColorStyle.light),
      ),
    ),
  );
}

void showDialogAssessment(
  BuildContext context,
  AssessmentModel assessmentModel,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: ColorStyle.light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

        contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: assessmentModel
                        .rowAssessmentModel
                        .assessment
                        .capitalizeFirst,
                    style: Fontstyle.defult(
                      18,
                      FontWeight.w700,
                      ColorStyle.Textblue,
                    ),
                  ),
                  TextSpan(
                    text:
                        "\n${assessmentModel.rowCourseModel.name} (${assessmentModel.rowCourseModel.code})",
                    style: Fontstyle.defult(
                      12,
                      FontWeight.normal,
                      ColorStyle.lightBlue,
                    ),
                  ),
                ],
              ),
            ),

            Divider(color: ColorStyle.red),
          ],
        ),
        content: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// DATE & TIME
            _infoRow(
              icon: Icons.schedule,
              title: 'Date',

              subtitle:
                  "${DateFormat('d MMM').format(assessmentModel.rowAssessmentModel.startTime)} at ${DatetimeStyle.formatTime12Hour(assessmentModel.rowAssessmentModel.startTime, context)}",
            ),

            /// ROOM
            _infoRow(
              icon: Icons.meeting_room_outlined,
              title: "Room",
              subtitle: assessmentModel.rowAssessmentModel.room.isEmpty
                  ? "Not Assigned"
                  : assessmentModel.rowAssessmentModel.room,
            ),

            /// INSTRUCTORS
            _infoRow(
              icon: Icons.person_outline,
              title: "Instructor",
              subtitle: assessmentModel.rowAssessmentModel.instructor.join(
                " • ",
              ),
            ),

            /// SYLLABUS
            _infoRow(
              icon: Icons.description_outlined,
              title: "Syllabus",
              subtitle:
                  assessmentModel.rowAssessmentModel.syllabus.capitalizeFirst!,
              maxLines: 3,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyle.red,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final url = assessmentModel.gClassRoom.trim();
                  final uri = Uri.tryParse(url);

                  if (uri == null) {
                    debugPrint('Invalid URL');
                    return;
                  }
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    debugPrint('Cannot launch $url');
                  }
                },

                child: Text(
                  "Course Material",
                  style: Fontstyle.defult(
                    14,
                    FontWeight.w600,
                    ColorStyle.light,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _infoRow({
  required IconData icon,
  required String title,
  required String subtitle,
  int maxLines = 100,
}) {
  return Row(
    spacing: 6,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 18, color: ColorStyle.red),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Fontstyle.defult(14, FontWeight.w600, ColorStyle.Textblue),
            ),
            Text(
              subtitle,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,

              style: Fontstyle.defult(
                14,
                FontWeight.w500,
                ColorStyle.lightBlue,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
