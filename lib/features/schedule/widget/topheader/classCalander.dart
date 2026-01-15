// ignore_for_file: deprecated_member_use

import 'package:academicpanel/controller/page/schedule_page_contoller.dart';
import 'package:academicpanel/features/schedule/widget/topheader/classSchedule.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Classcalander extends StatefulWidget {
  final SchedulePageContoller schedulePageContoller;

  const Classcalander({super.key, required this.schedulePageContoller});

  @override
  State<Classcalander> createState() => _ClasscalanderState();
}

class _ClasscalanderState extends State<Classcalander> {
  final focusedDate = DateTime.now().obs;
  final days = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];

  // Change this line:
  String get dayKey => days[focusedDate.value.weekday - 1];

  late ScrollController _scrollController;
  late List<DateTime> _dates;
  late String _bgImage;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _setupCalendar();

    // // 5. Scroll to today automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToDate(focusedDate.value);
    });
  }

  void _setupCalendar() {
    final now = DateTime.now();

    // 2. Simple Image Logic
    if (now.month <= 4) {
      _bgImage = ImageStyle.spring();
    } else if (now.month <= 8) {
      _bgImage = ImageStyle.summer();
    } else {
      _bgImage = ImageStyle.fall();
    }

    int lastDay = DateTime(now.year, now.month + 1, 0).day;

    // Generate list: [Jan 1, Jan 2, ... Jan 31]
    _dates = List.generate(lastDay, (index) {
      return DateTime(now.year, now.month, index + 1);
    });
  }

  void _scrollToDate(DateTime date) {
    int index = date.day - 1;

    double itemWidth = 80.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double offset = (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

    if (offset < 0) offset = 0;

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  final Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    final controller = widget.schedulePageContoller;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurStyle: BlurStyle.outer,
                blurRadius: 6,
                offset: Offset(0, -0.6),
                spreadRadius: 1,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            image: DecorationImage(
              image: AssetImage(_bgImage),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.srcOver,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              // 1. Simple Header: "15, January" and Semester
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('d, MMMM').format(selectedDate.value),
                        style: Fontstyle.defult(
                          22,
                          FontWeight.bold,
                          ColorStyle.light,
                        ),
                      ),
                      Text(
                        DateFormat('EEEE').format(selectedDate.value),
                        style: Fontstyle.defult(
                          18,
                          FontWeight.w600,
                          ColorStyle.light,
                        ),
                      ),
                    ],
                  );
                }),
              ),

              // Horizontal List
              SizedBox(
                height: 100,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _dates.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final date = _dates[index];
                    String dayShort = DateFormat(
                      'EEEE',
                    ).format(date).toLowerCase().substring(0, 2);
                    bool hasEvent = widget
                        .schedulePageContoller
                        .classSchedulePageSchedule
                        .value
                        .days
                        .contains(dayShort);
                    return GestureDetector(
                      onTap: () {
                        selectedDate.value = date;
                        focusedDate.value = date;
                        _scrollToDate(date);
                        controller.fetchclassScheduleCalander(dayShort);
                      },
                      child: Obx(() {
                        final isSelected =
                            date.day == selectedDate.value.day &&
                            date.month == selectedDate.value.month &&
                            date.year == selectedDate.value.year;

                        return Container(
                          width: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected || hasEvent
                                  ? Colors.white
                                  : Colors.white30,
                              width: 1.5,
                            ),
                            color: isSelected
                                ? Colors.white24
                                : Colors.transparent,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('E').format(date).toUpperCase(),
                                style: Fontstyle.defult(
                                  14,
                                  FontWeight.w600,
                                  hasEvent ? Colors.white : Colors.white60,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                height: 2,
                                width: 20,
                                color: hasEvent ? Colors.white : Colors.white60,
                              ),
                              Text(
                                date.day.toString(),
                                style: Fontstyle.defult(
                                  20,
                                  FontWeight.w600,
                                  hasEvent ? Colors.white : Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(height: 20, width: 2, color: ColorStyle.red),
              ),
              Classschedule(schedulePageContoller: controller),
            ],
          ),
        ),
      ],
    );
  }
}
