import 'package:academicpanel/controller/page/schedule_page_contoller.dart';
import 'package:academicpanel/features/schedule/widget/topheader/classCalander.dart';
import 'package:academicpanel/theme/style/color_style.dart';
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
        leading: SizedBox.shrink(),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black26,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: ColorStyle.light,
      body: Column(
        children: [Classcalander(schedulePageContoller: schedulePageContoller)],
      ),
    );
  }
}
