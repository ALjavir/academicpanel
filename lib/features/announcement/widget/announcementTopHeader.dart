import 'dart:ui';

import 'package:academicpanel/model/pages/announcemrnt_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threeD_containerHead.dart';
import 'package:flutter/material.dart';

class Announcementtopheader extends StatelessWidget {
  final AnnouncementPageTopHeader announcementPageTopHeader;
  const Announcementtopheader({
    super.key,
    required this.announcementPageTopHeader,
  });

  @override
  Widget build(BuildContext context) {
    return ThreedContainerhead(
      padding: EdgeInsets.fromLTRB(10, 60, 10, 30),
      imagePath: ImageStyle.announcementBackground(),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          blendMode: BlendMode.srcOver,
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: AlignmentGeometry.center,

            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white60),
              borderRadius: BorderRadius.circular(10),
              color: ColorStyle.glassWhite,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  "Announcement",
                  style: Fontstyle.defult(
                    22,
                    FontWeight.w600,
                    ColorStyle.light,
                  ),
                ),
                Divider(thickness: 1.5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: 10,
                  children: [
                    showData("Total", announcementPageTopHeader.totalAnn),
                    Container(
                      width: 2,
                      height: MediaQuery.of(context).size.height * 0.06,
                      color: Colors.white30,
                    ),
                    showData("New", announcementPageTopHeader.newAnnNum),
                    Container(
                      width: 2,
                      height: MediaQuery.of(context).size.height * 0.06,
                      color: Colors.white30,
                    ),
                    showData("Source", announcementPageTopHeader.totalCourse),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showData(String title, int number) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number.toString(),
          style: Fontstyle.defult(28, FontWeight.bold, ColorStyle.light),
        ),
        Text(
          title,
          style: Fontstyle.defult(14, FontWeight.w500, Colors.white70),
        ),
      ],
    );
  }
}
