import 'package:academicpanel/model/global/classSchedule_model.dart';
import 'package:academicpanel/theme/animation/threed_containel.dart';

import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:lottie/lottie.dart';

class TodayClassschedule extends StatefulWidget {
  final List<ClassscheduleModel> todayClass;
  const TodayClassschedule({super.key, required this.todayClass});

  @override
  State<TodayClassschedule> createState() => _TodayClassscheduleState();
}

class _TodayClassscheduleState extends State<TodayClassschedule> {
  @override
  Widget build(BuildContext context) {
    String formatTime12Hour(String time24) {
      // 1. Handle Bad Data (Optional safety)
      if (time24 == "no" || time24.isEmpty) return "TBA";

      try {
        final parts = time24.split(':');
        final time = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
        return time.format(context);
      } catch (e) {
        return time24; // Fallback if parsing fails
      }
    }

    return widget.todayClass.isEmpty
        ? ThreedContainel(
            redious: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                LottieBuilder.asset(
                  ImageStyle.upCommingClassaAimatedIcon(),
                  frameRate: FrameRate.max,
                ),
                //   Image.asset(ImageStyle.no_class(), scale: 4),
                Text(
                  "No Class Today",
                  style: Fontstyle.defult(
                    18,
                    FontWeight.bold,
                    ColorStyle.Textblue,
                  ),
                ),
              ],
            ),
          )
        : ThreedContainel(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upcoming Class",
                      style: Fontstyle.defult3d(
                        22,
                        FontWeight.bold,
                        ColorStyle.Textblue,
                        const Color.fromARGB(20, 19, 70, 125),
                        const Offset(3, 3),
                        4,
                      ),
                    ),
                    Image.asset(
                      ImageStyle.upCommingClassesHeaderIcon(),
                      color: ColorStyle.red,
                      scale: 22,
                    ),
                  ],
                ),
                Divider(color: ColorStyle.red),
                const SizedBox(height: 5),

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
                                "${widget.todayClass[0].name.capitalizeFirst!} - (${widget.todayClass[0].code})",
                                style: Fontstyle.defult(
                                  18,
                                  FontWeight.bold,
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
                                      14,
                                      FontWeight.w700,
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
                                      14,
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
                                    widget.todayClass[0].instracter,
                                    style: Fontstyle.defult(
                                      14,
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
                                    padding: const EdgeInsets.only(
                                      bottom: 12.0,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                widget.todayClass[i].name,
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
