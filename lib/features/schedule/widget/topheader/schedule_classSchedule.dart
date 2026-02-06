import 'package:academicpanel/controller/page/schedule_page_contoller.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/normal/dotLine_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/state_manager.dart';
import 'package:lottie/lottie.dart';

class ScheduleClassschedule extends StatefulWidget {
  final SchedulePageContoller schedulePageContoller;
  const ScheduleClassschedule({super.key, required this.schedulePageContoller});

  @override
  State<ScheduleClassschedule> createState() => _ScheduleClassscheduleState();
}

class _ScheduleClassscheduleState extends State<ScheduleClassschedule> {
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

    final controller = widget.schedulePageContoller;

    return ThreeDContainel(
      redious: 10,
      child: Obx(() {
        final scheduleList =
            controller.classSchedulePageSchedule.value.classSchedule;
        final noClass = controller.classSchedulePageSchedule.value.noClass;

        // 3. Now the condition is reactive!
        if (noClass != null)
          return SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // spacing: 10,
                children: [
                  Image.asset(
                    noClass.type.toLowerCase() == 'test'
                        ? ImageStyle.exam()
                        : ImageStyle.holidays(),
                    scale: 5,
                  ),
                  Text(
                    noClass.title,
                    style: Fontstyle.defult(
                      18,
                      FontWeight.bold,
                      ColorStyle.Textblue,
                    ),
                  ),
                ],
              ),
            ),
          );
        else if (scheduleList.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 10),
            ],
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                controller.classSchedulePageSchedule.value.classSchedule.length,
            itemBuilder: (context, index) {
              final item = controller
                  .classSchedulePageSchedule
                  .value
                  .classSchedule[index];
              final isLast =
                  index ==
                  controller
                          .classSchedulePageSchedule
                          .value
                          .classSchedule
                          .length -
                      1;

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 6,
                        children: [
                          Text(
                            "${item.rowCourseModel.name.capitalizeFirst!} (${item.rowCourseModel.code})",
                            style: Fontstyle.defult(
                              15,
                              FontWeight.bold,
                              ColorStyle.Textblue,
                            ),
                          ),
                          Row(
                            spacing: 4,
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: ColorStyle.red,
                                size: 14,
                              ),

                              Text(
                                "${formatTime12Hour(item.rowClassscheduleModel.startTime)} - ${formatTime12Hour(item.rowClassscheduleModel.endTime)}",
                                style: Fontstyle.defult(
                                  14,
                                  FontWeight.w500,
                                  ColorStyle.Textblue,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            spacing: 4,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: ColorStyle.red,
                                size: 16,
                              ),

                              Text(
                                item.rowClassscheduleModel.room,
                                style: Fontstyle.defult(
                                  14,
                                  FontWeight.w500,
                                  ColorStyle.Textblue,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.person_outline,
                                color: ColorStyle.red,
                                size: 16,
                              ),

                              Text(
                                item.instructor,
                                style: Fontstyle.defult(
                                  14,
                                  FontWeight.w500,
                                  ColorStyle.Textblue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
