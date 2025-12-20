import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class TodayClassschedule extends StatefulWidget {
  final TodayClassSchedule todayClass;
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

    return Container(
      height: MediaQuery.heightOf(context) * 0.36,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorStyle.light,
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(12, 0, 0, 0), // Soft dark shadow
            blurRadius: 6,

            // offset: Offset(0, 6), // Softness
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            spacing: 10,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Upcoming  Class",

                style: Fontstyle.defult3d(
                  22,

                  FontWeight.bold,

                  ColorStyle.Textblue,

                  const Color.fromARGB(20, 19, 70, 125),

                  const Offset(3, 3),

                  4,
                ),
              ),

              Image.asset(ImageStyle.book(), color: ColorStyle.red, scale: 22),
            ],
          ),

          Divider(color: ColorStyle.red),
          const SizedBox(
            height: 5,
          ), // 1. IntrinsicHeight calculates the height of the tallest side
          IntrinsicHeight(
            child: Center(
              child: Row(
                // 2. CRITICAL: stretch forces the Divider to fill the vertical space
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ================== LEFT SIDE ==================
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 12,
                      children: [
                        // ... your Left Side Text/Rows ...
                        // (This code remains exactly the same as yours)
                        Text(
                          "${widget.todayClass.classTimeInfo![0].name.capitalizeFirst!} - (${widget.todayClass.classTimeInfo![0].code})",
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
                              "${formatTime12Hour(widget.todayClass.classTimeInfo![0].startTime)} - ${formatTime12Hour(widget.todayClass.classTimeInfo![0].endTime)}",

                              // "10:30 AM - 12:00 PM",
                              style: Fontstyle.defult(
                                14,

                                FontWeight.w700,

                                ColorStyle.Textblue,
                              ),
                            ),
                          ],
                        ),

                        // 3. Location & Professor Row
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,

                              color: ColorStyle.red,

                              size: 20,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              widget.todayClass.classTimeInfo![0].room,

                              style: Fontstyle.defult(
                                14,

                                FontWeight.w600,

                                ColorStyle.Textblue,
                              ),
                            ),

                            const SizedBox(width: 16), // Gap between items

                            Icon(
                              Icons.person_outline,

                              color: Colors.red[900],

                              size: 20,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              widget.todayClass.classTimeInfo![0].instracter,

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

                  // ================== THE DIVIDER LINE ==================
                  Container(
                    width: 2,

                    color: Colors.grey.shade300,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),

                  // ================== RIGHT SIDE (Fixed) ==================
                  Expanded(
                    flex: 2,
                    // 3. FIX: Replaced ListView with Column
                    // Column calculates height instantly, making IntrinsicHeight happy.
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // We manually loop through the list, skipping index 0
                        for (
                          int i = 1;
                          i < widget.todayClass.classTimeInfo!.length;
                          i++
                        ) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // The Red Dot
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
                                // The Text Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget
                                            .todayClass
                                            .classTimeInfo![i]
                                            .name,
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
                                        "${formatTime12Hour(widget.todayClass.classTimeInfo![i].startTime)} - ${formatTime12Hour(widget.todayClass.classTimeInfo![i].endTime)}",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
