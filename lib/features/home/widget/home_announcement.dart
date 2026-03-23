import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/normal/announcement_template.dart';
import 'package:academicpanel/theme/template/normal/showIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

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
              ShowIcon(size: 28, imageName: ImageStyle.announcementIcon()),

              // Image.asset(
              //   ImageStyle.announcementIcon(),
              //   color: ColorStyle.red,
              //   scale: 19,
              // ),
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
          if (announcements == null || announcements!.isEmpty) ...[
            ClipRect(
              child: SizedBox(
                height: 120,
                width: double.maxFinite,
                child: Transform.scale(
                  scale: 2,
                  child: LottieBuilder.asset(
                    ImageStyle.upCommingClassaAimatedIcon(),
                    frameRate: FrameRate.max,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "No announcement found...",
                  style: Fontstyle.defult(
                    18,
                    FontWeight.w500,
                    ColorStyle.Textblue,
                  ),
                ),
              ),
            ),
          ] else
            AnnouncementTemplate(announcement: announcements ?? []),
        ],
      ),
    );
  }
}
