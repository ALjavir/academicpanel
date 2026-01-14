// ignore_for_file: deprecated_member_use

import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HorizontalCalendar extends StatefulWidget {
  final String semester;
  final DateTime focusedDate;
  final List<String> activeWeekdays;

  const HorizontalCalendar({
    super.key,
    required this.semester,
    required this.focusedDate,
    required this.activeWeekdays,
  });

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
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
      _scrollToDate(widget.focusedDate);
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
    // Find index of the date (Day 15 is at index 14)
    int index = date.day - 1;

    // Simple math to center the item
    double itemWidth = 80.0; // 65 width + 12 margin (approx)
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(_bgImage), fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Simple Header: "15, January" and Semester
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        DateFormat('d, MMMM').format(selectedDate.value),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                    Text(
                      widget.semester,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Horizontal List
          SizedBox(
            height: 110,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _dates.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final date = _dates[index];

                // 4. Simplified "Day Key" Logic
                // "Monday" -> "monday" -> substring(0,2) -> "mo"
                String dayShort = DateFormat(
                  'EEEE',
                ).format(date).toLowerCase().substring(0, 2);
                bool hasEvent = widget.activeWeekdays.contains(dayShort);
                return GestureDetector(
                  onTap: () {
                    selectedDate.value = date;
                    _scrollToDate(date);
                  },
                  child: Obx(() {
                    final isSelected =
                        date.day == selectedDate.value.day &&
                        date.month == selectedDate.value.month &&
                        date.year == selectedDate.value.year;

                    return Container(
                      width: 65,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.white30,
                          width: 1.5,
                        ),
                        color: isSelected
                            ? Colors.white.withOpacity(0.1)
                            : Colors.transparent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('E').format(date).toUpperCase(),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            height: 2,
                            width: 20,
                            color: hasEvent ? Colors.white : Colors.transparent,
                          ),
                          Text(
                            date.day.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
    );
  }
}
