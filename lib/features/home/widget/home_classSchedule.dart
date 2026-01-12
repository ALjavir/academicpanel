import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/theme/animation/threed_containel.dart';

import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:lottie/lottie.dart';

class HomeClassschedule extends StatefulWidget {
  final List<ClassscheduleModel> todayClass;
  const HomeClassschedule({super.key, required this.todayClass});

  @override
  State<HomeClassschedule> createState() => _HomeClassscheduleState();
}

class _HomeClassscheduleState extends State<HomeClassschedule> {
  @override
  Widget build(BuildContext context) {
    String formatTime12Hour(String time24) {
      try {
        final parts = time24.split(':');
        final time = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
        return time.format(context);
      } catch (e) {
        return time24;
      }
    }

    return ThreeDContainel(
      redious: 10,
      boxConstraints: BoxConstraints(
        minHeight: 100, // Minimum height for 1 class
        // Max height 30% of screen if you want scrolling inside, otherwise remove max
        maxHeight: double.infinity,
      ),

      padding: const EdgeInsets.all(12),

      child: Column(
        mainAxisSize: MainAxisSize.min, // Hug content
        children: [
          // HEADER
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Image.asset(
                ImageStyle.upCommingClassesHeaderIcon(),
                color: ColorStyle.red,
                scale: 19,
              ),
              Text(
                "Upcoming Class",
                style: Fontstyle.defult(
                  22,
                  FontWeight.w600,
                  ColorStyle.Textblue,
                ),
              ),
            ],
          ),
          Divider(color: ColorStyle.red),

          if (widget.todayClass.isEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // spacing: 10,
              children: [
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

                Text(
                  "No class for now, relax!",
                  style: Fontstyle.defult(
                    18,
                    FontWeight.bold,
                    ColorStyle.Textblue,
                  ),
                ),
              ],
            )
          else
            // CONTENT
            IntrinsicHeight(
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ================== LEFT SIDE (Main Class) ==================
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 12,
                        children: [
                          Text(
                            "${widget.todayClass[0].course.name.capitalizeFirst!} - (${widget.todayClass[0].course.code})",
                            style: Fontstyle.defult(
                              16.5,
                              FontWeight.w600,
                              ColorStyle.Textblue,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: ColorStyle.red,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${formatTime12Hour(widget.todayClass[0].startTime)} - ${formatTime12Hour(widget.todayClass[0].endTime)}",
                                style: Fontstyle.defult(
                                  14.5,
                                  FontWeight.w600,
                                  ColorStyle.Textblue,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: ColorStyle.red,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.todayClass[0].room,
                                style: Fontstyle.defult(
                                  14.5,
                                  FontWeight.w600,
                                  ColorStyle.Textblue,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.person_outline,
                                color: Colors.red[900],
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.todayClass[0].instructor,
                                style: Fontstyle.defult(
                                  14.5,
                                  FontWeight.w600,
                                  ColorStyle.Textblue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ================== RIGHT SIDE (Dynamic) ==================

                    // 2. FIX: Use "Collection If". No need for ternary operators or SizedBox.shrink
                    if (widget.todayClass.length > 1) ...[
                      // The Divider
                      Container(
                        width: 2,
                        color: Colors.grey.shade300,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                      ),

                      // The List
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Loop starting from index 1
                            for (
                              int i = 1;
                              i < widget.todayClass.length;
                              i++
                            ) ...[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Transform.translate(
                                      offset: const Offset(-14, 4),
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.red[900],
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget
                                                .todayClass[i]
                                                .course
                                                .name
                                                .capitalizeFirst!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Fontstyle.defult(
                                              12,
                                              FontWeight.w600,
                                              ColorStyle.lightBlue,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            "${formatTime12Hour(widget.todayClass[i].startTime)} - ${formatTime12Hour(widget.todayClass[i].endTime)}",
                                            style: Fontstyle.defult(
                                              12,
                                              FontWeight.w500,
                                              ColorStyle.lightBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ], // End of "if length > 1" block
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
