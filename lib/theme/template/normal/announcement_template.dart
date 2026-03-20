import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
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
                      overflow: TextOverflow.ellipsis,
                      style: Fontstyle.defult(
                        16,
                        FontWeight.w600,
                        ColorStyle.Textblue,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: Fontstyle.defult(
                          13,
                          FontWeight.w500,
                          ColorStyle.lightBlue,
                        ),
                        children: [
                          TextSpan(
                            text:
                                "${item.rowCourseModel.name.capitalizeFirst!}",
                          ),
                          if (item.rowCourseModel.code != 'N/A')
                            TextSpan(text: " (${item.rowCourseModel.code})"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // --- RIGHT SECTION: Time Badge ---
              InkWell(
                onTap: () {
                  showDialogAnnouncement(context, item);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
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
                    "${DatetimeStyle.announcementTime(item.rowAnnouncementModel.createdAt)} ->",
                    style: Fontstyle.defult(
                      10,
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

  void showDialogAnnouncement(
    BuildContext context,
    AnnouncementModel announcement,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorStyle.light,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          title: Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DatetimeStyle.announcementTime(
                      announcement.rowAnnouncementModel.createdAt,
                    ),
                    style: Fontstyle.defult(
                      18,
                      FontWeight.w600,
                      ColorStyle.Textblue,
                    ),
                  ),
                  Icon(Icons.brightness_1, size: 6, color: ColorStyle.red),
                  Text(
                    DatetimeStyle.formatTime12Hour(
                      announcement.rowAnnouncementModel.createdAt,
                      context,
                    ),
                    style: Fontstyle.defult(
                      18,
                      FontWeight.w600,
                      ColorStyle.Textblue,
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${announcement.rowCourseModel.name}",
                      style: Fontstyle.defult(
                        12,
                        FontWeight.normal,
                        ColorStyle.lightBlue,
                      ),
                    ),
                    if (announcement.rowCourseModel.code != 'N/A')
                      TextSpan(
                        text: " (${announcement.rowCourseModel.code})",
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
          content: Text(
            announcement.rowAnnouncementModel.message.capitalizeFirst!,

            softWrap: true,
            style: Fontstyle.defult(16, FontWeight.w500, ColorStyle.Textblue),
          ),
        );
      },
    );
  }
}
