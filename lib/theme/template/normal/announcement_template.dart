import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/hybridDate_style.dart';
import 'package:flutter/material.dart';

class AnnouncementTemplate extends StatelessWidget {
  final List<AnnouncementModel> announcement;
  const AnnouncementTemplate({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(6), // Remove default padding
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Keeps it stable inside your Dashboard
      itemCount: announcement.length,
      itemBuilder: (context, index) {
        final item = announcement[index];
        final isLast = index == announcement.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
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

              // --- MIDDLE SECTION: Content ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    // Title (Message)
                    Text(
                      item.message,
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
    );
  }
}
