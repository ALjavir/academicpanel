import 'dart:ui';
import 'package:academicpanel/controller/page/schedule_page_contoller.dart';
import 'package:academicpanel/features/home/home_page_main.dart';
import 'package:academicpanel/features/schedule/schedule_page_main.dart';
import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final RxInt _currentIndex = 0.obs;
  final schedulePageContoller = Get.put(SchedulePageContoller());
  late Future<List<RowAcademiccalendarModel>> data = schedulePageContoller
      .fetchAcademicCalendar();

  final List<Widget> _pages = [HomePageMain(), SchedulePageMain()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.grey[200],

      body: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 10),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: _pages[_currentIndex.value],
        );
      }),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black12, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _navItem(ImageStyle.navHome(), 0),
                  _navItem(ImageStyle.navSchedule(), 1),
                  _navItem(ImageStyle.navAnnouncement(), 2),
                  _navItem(ImageStyle.navResult(), 3),
                  _navItem(ImageStyle.navAccount(), 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Helper widget
  Widget _navItem(String image, int index) {
    return Obx(() {
      final bool isSelected = _currentIndex.value == index;

      return GestureDetector(
        onTap: () {
          _currentIndex.value = index;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? ColorStyle.red : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            image,
            color: isSelected ? Colors.white : ColorStyle.Textblue,
            scale: 18,
          ),
        ),
      );
    });
  }
}
