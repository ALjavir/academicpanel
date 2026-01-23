import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/hybridDate_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

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

        // contentPadding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        // titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              assessmentModel.assessment.capitalizeFirst!,
              style: Fontstyle.defult(18, FontWeight.w700, ColorStyle.Textblue),
            ),
            const SizedBox(height: 6),
            Divider(color: ColorStyle.red),
          ],
        ),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// COURSE
            _infoRow(
              icon: Icons.book_outlined,
              title:
                  "${assessmentModel.rowCourseModel.name} (${assessmentModel.rowCourseModel.code})",
            ),

            const SizedBox(height: 12),

            /// DATE & TIME
            _infoRow(
              icon: Icons.schedule,
              title:
                  "${HybriddateStyle.getHybridDate(assessmentModel.startTime)}",
              // subtitle:
              //     "${HybriddateStyle.getHybridDate(assessmentModel.startTime, assessmentModel.endTime)}",
            ),

            const SizedBox(height: 12),

            /// ROOM
            _infoRow(
              icon: Icons.meeting_room_outlined,
              title: "Room",
              subtitle: assessmentModel.room.isEmpty
                  ? "Not Assigned"
                  : assessmentModel.room,
            ),

            const SizedBox(height: 12),

            /// INSTRUCTORS
            _infoRow(
              icon: Icons.person_outline,
              title: "Instructor",
              subtitle: assessmentModel.instructor.join(" • "),
            ),

            const SizedBox(height: 12),

            /// SYLLABUS
            _infoRow(
              icon: Icons.description_outlined,
              title: "Syllabus",
              subtitle: assessmentModel.syllabus,
              maxLines: 3,
            ),

            if (assessmentModel.link.isNotEmpty) ...[
              const SizedBox(height: 18),

              /// ACTION BUTTON
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
                  onPressed: () {
                    // open link
                  },
                  child: Text(
                    "Open Link",
                    style: Fontstyle.defult(
                      14,
                      FontWeight.w600,
                      ColorStyle.light,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    },
  );
}

Widget _infoRow({
  required IconData icon,
  required String title,
  String? subtitle,
  int maxLines = 2,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 18, color: ColorStyle.red),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Fontstyle.defult(14, FontWeight.w600, ColorStyle.Textblue),
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  subtitle,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: Fontstyle.defult(
                    12,
                    FontWeight.w500,
                    ColorStyle.lightBlue,
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}
