import 'package:academicpanel/controller/page/schedule_page_contoller.dart';
import 'package:academicpanel/features/schedule/widget/topheader/schedule_AcademicCalendar.dart';
import 'package:academicpanel/features/schedule/widget/topheader/schedule_CalanderView.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class SchedulePageMain extends StatefulWidget {
  const SchedulePageMain({super.key});

  @override
  State<SchedulePageMain> createState() => _SchedulePageMainState();
}

class _SchedulePageMainState extends State<SchedulePageMain> {
  final schedulePageContoller = Get.put(SchedulePageContoller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: const SizedBox.shrink(),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: GestureDetector(
              onTap: () async {
                await schedulePageContoller.fetchAcademicCalendar();
                scheduleAcademicCalendar(
                  context,
                  schedulePageContoller.academicCalendarData,
                );
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  border: Border.all(color: ColorStyle.light),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      blurStyle: BlurStyle.outer,
                      blurRadius: 5,

                      spreadRadius: 0.1,
                    ),
                  ],
                ),
                child: Image.asset(
                  ImageStyle.navSchedule(),
                  color: Colors.white,
                  scale: 16,
                ),
              ),
            ),
          ),
        ],

        // ---------------------------------------------------------
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black26,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: ColorStyle.light,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Now you can remove the broken button code inside this widget
            ScheduleCalanderview(schedulePageContoller: schedulePageContoller),
          ],
        ),
      ),
    );
  }
}
