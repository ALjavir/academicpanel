import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/theme/animation/threed_containel.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';

class HomeAssessment extends StatelessWidget {
  final List<AssessmentModel> assessment;
  const HomeAssessment({super.key, required this.assessment});

  String _timeAgo(DateTime d) {
    final Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 0) return "${diff.inDays}d ago";
    if (diff.inHours > 0) return "${diff.inHours}h ago";
    if (diff.inMinutes > 0) return "${diff.inMinutes}m ago";
    return "Just now";
  }

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
            ListView.builder(
              padding: EdgeInsets.zero, // Remove default padding
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Keeps it stable inside your Dashboard
              itemCount: assessment.length,
              itemBuilder: (context, index) {
                final item = assessment[index];
                final isLast = index == assessment.length - 1;

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
                          _timeAgo(item.date),
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
