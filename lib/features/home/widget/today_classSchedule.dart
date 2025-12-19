import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
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
        // 2. Parse "14:30" -> Hour: 14, Minute: 30
        final parts = time24.split(':');
        final time = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );

        // 3. The Magic Line: Converts to "2:30 PM" automatically
        return time.format(context);
      } catch (e) {
        return time24; // Fallback if parsing fails
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
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

            Image.asset(ImageStyle.book(), color: ColorStyle.red, scale: 20),
          ],
        ),
        Container(
          height: MediaQuery.heightOf(context) * 0.3,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorStyle.light,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(12, 0, 0, 0), // Soft dark shadow
                blurRadius: 6,
                offset: Offset(6, 6), // Softness
                spreadRadius: 3,
              ),
            ],
          ),
          child: IntrinsicHeight(
            // <--- 1. CRITICAL: Makes the divider stretch to full height
            child: Row(
              children: [
                // ================== LEFT SIDE (Main Class) ==================
                Expanded(
                  flex: 3, // Takes 60% of width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      // 1. Course Name
                      Text(
                        "${widget.todayClass.classTimeInfo![0].name.capitalizeFirst!} - (${widget.todayClass.classTimeInfo![0].code})",
                        // "Data Science(CSE-322)",
                        style: Fontstyle.defult(
                          18,
                          FontWeight.bold,
                          ColorStyle.Textblue,
                        ),
                      ),

                      // 2. Time
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
                  width: 2, // Thickness of the grey line
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),

                // ================== RIGHT SIDE (List) ==================
                Expanded(
                  flex: 2, // Takes 40% of width
                  child: ListView.builder(
                    shrinkWrap: true,

                    itemCount:
                        widget.todayClass.classTimeInfo!.length -
                        1, // Skip the first one (0)
                    itemBuilder: (context, index) {
                      final realIndex = index + 1;

                      return Padding(
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

                            // 4. List Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget
                                        .todayClass
                                        .classTimeInfo![realIndex]
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
                                    "${formatTime12Hour(widget.todayClass.classTimeInfo![realIndex].startTime)} - ${formatTime12Hour(widget.todayClass.classTimeInfo![realIndex].endTime)}",
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
