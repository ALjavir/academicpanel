import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/normal/announcement_template.dart';
import 'package:flutter/material.dart';

class HomeAnnouncement extends StatelessWidget {
  final List<AnnouncementModel>? announcements;

  const HomeAnnouncement({super.key, required this.announcements});

  @override
  Widget build(BuildContext context) {
    return ThreeDContainel(
      padding: EdgeInsets.all(12),
      redious: 10,
      child: Column(
        children: [
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Image.asset(
                ImageStyle.announcementIcon(),
                color: ColorStyle.red,
                scale: 19,
              ),
              Text(
                "Announcement",
                style: Fontstyle.defult(
                  22,
                  FontWeight.w600,
                  ColorStyle.Textblue,
                ),
              ),
            ],
          ),
          Divider(color: ColorStyle.red),
          if (announcements == null || announcements!.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "No announcements yet!!!",
                  style: Fontstyle.defult(18, FontWeight.w600, ColorStyle.red),
                ),
              ),
            )
          else
            AnnouncementTemplate(announcement: announcements ?? []),
        ],
      ),
    );
  }
}
