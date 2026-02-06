import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/dateTime_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/template/normal/dotLine_template.dart';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class AnnouncementTemplate extends StatelessWidget {
  final List<AnnouncementModel> announcement;
  const AnnouncementTemplate({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: announcement.length,
      itemBuilder: (context, index) {
        final item = announcement[index];
        final isLast = index == announcement.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              DotlineTemplate(isLast: isLast, index: index),

              // --- MIDDLE SECTION: Content ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    // Title (Message)
                    Text(
                      item.rowAnnouncementModel.message.capitalizeFirst!,
                      maxLines: 2,
                      softWrap: true,
                      style: Fontstyle.defult(
                        16,
                        FontWeight.w600,
                        ColorStyle.Textblue,
                      ),
                    ),

                    Text(
                      "${item.rowCourseModel.name.capitalizeFirst!} (${item.rowCourseModel.code})",
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
                  DatetimeStyle.getHybridDate(item.rowAnnouncementModel.date),
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
