// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';

void scheduleAcademicCalendar(
  BuildContext context,
  List<RowAcademiccalendarModel> events,
) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                blendMode: BlendMode.srcOver,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white54),
                    borderRadius: BorderRadius.circular(10),
                    color: ColorStyle.glassWhite,
                  ),

                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Use minimum height needed
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Image.asset(
                            ImageStyle.navSchedule(),
                            scale: 18,
                            color: ColorStyle.light,
                          ),
                          Text(
                            "Academic Calendar ",
                            style: Fontstyle.defult(
                              22,
                              FontWeight.bold,
                              ColorStyle.light,
                            ),
                          ),
                        ],
                      ),
                      Divider(color: ColorStyle.light, thickness: 1),

                      // --- The List ---
                      // Wrapped in Expanded so it scrolls properly inside the constraints
                      if (events.length == 0)
                        Text(
                          "No data found!!!",
                          style: Fontstyle.defult(
                            22,
                            FontWeight.w600,
                            ColorStyle.light,
                          ),
                        )
                      else
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            shrinkWrap: true, // Okay inside Column+Expanded
                            // REMOVED: physics: NeverScrollableScrollPhysics(), (We want it to scroll!)
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              final event = events[index];
                              return TimelineTile(
                                date: event.date,
                                day: event.day,
                                title: event.title,
                                type: event.type,
                                isLast: index == events.length - 1,
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class TimelineTile extends StatelessWidget {
  final String date;
  final String day;
  final String title;
  final String type;
  final bool isLast;

  const TimelineTile({
    super.key,
    required this.date,
    required this.day,
    required this.title,
    required this.type,
    this.isLast = false,
  });

  Color _getColor() {
    switch (type) {
      case 'holiday':
        return Colors.red;
      case 'exam':
        return Colors.purple;
      case 'payment':
        return Colors.orange;
      case 'reg':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // 1. Date Column
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: 55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    date,

                    textAlign: TextAlign.right,
                    style: Fontstyle.defult(
                      14,
                      FontWeight.w600,
                      ColorStyle.light,
                    ),
                  ),
                  Text(
                    day,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: Fontstyle.defult(
                      10,
                      FontWeight.w600,
                      ColorStyle.light.withOpacity(0.6),
                    ),
                  ),
                  //const SizedBox(height: 20), // Spacing
                ],
              ),
            ),
          ),

          // 2. The Vertical Line & Dot
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _getColor(),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white10, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: _getColor().withOpacity(0.4),
                        blurRadius: 1,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 1, color: Colors.grey.shade200),
                ),
            ],
          ),

          // 3. The Content Card
          Expanded(
            child: Container(
              // padding: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Fontstyle.defult(
                        16,
                        FontWeight.w600,
                        ColorStyle.light,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
