import 'dart:ui';

import 'package:academicpanel/model/pages/announcemrnt_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threeD_containerHead.dart';
import 'package:academicpanel/theme/template/normal/showIcon.dart';
import 'package:flutter/material.dart';

class Announcementtopheader extends StatelessWidget {
  final AnnouncementPageModel announcementPageModel;
  const Announcementtopheader({super.key, required this.announcementPageModel});

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

            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white54),
              borderRadius: BorderRadius.circular(10),
              color: ColorStyle.glassWhite,
            ),

            child: Column(
              spacing: 5,
              children: [
                Row(
                  children: [
                    Text(
                      "Announcement",
                      style: Fontstyle.defult(
                        22,
                        FontWeight.w600,
                        ColorStyle.light,
                      ),
                    ),
                    ShowIcon(size: 28, imageName: ImageStyle.pinBord()),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    showData("Total", announcementPageModel.totalAnn),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       textAlign: TextAlign.center,
                    //       'Hello, ${widget.homeTopHeaderModel.lastName.capitalizeFirst!}',

                    //       style: Fontstyle.defult(
                    //         22,
                    //         FontWeight.bold,
                    //         ColorStyle.light,
                    //       ),
                    //     ),
                    //     Row(
                    //       spacing: 5,
                    //       children: [
                    //         Text(
                    //           textAlign: TextAlign.center,
                    //           widget.homeTopHeaderModel.date,

                    //           style: Fontstyle.defult(
                    //             14,
                    //             FontWeight.w600,
                    //             ColorStyle.light,
                    //             // const Color.fromARGB(20, 19, 70, 125),
                    //             //  const Offset(3, 3),
                    //             // 4,
                    //           ),
                    //         ),
                    //         Container(
                    //           width: 5,
                    //           height: 5,
                    //           decoration: BoxDecoration(
                    //             color: ColorStyle.light,
                    //             shape: BoxShape.circle,
                    //           ),
                    //         ),
                    //         Text(
                    //           textAlign: TextAlign.center,
                    //           widget.homeTopHeaderModel.semester,

                    //           style: Fontstyle.defult(
                    //             14,
                    //             FontWeight.w600,
                    //             ColorStyle.light,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
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
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          number.toString(),
          style: Fontstyle.defult(14, FontWeight.w600, ColorStyle.light),
        ),
        Text(
          title,
          style: Fontstyle.defult(14, FontWeight.w600, ColorStyle.light),
        ),
      ],
    );
  }
}
