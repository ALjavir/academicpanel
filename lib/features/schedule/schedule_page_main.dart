import 'package:academicpanel/features/schedule/widget/test.dart';
import 'package:flutter/material.dart';

class SchedulePageMain extends StatefulWidget {
  const SchedulePageMain({super.key});

  @override
  State<SchedulePageMain> createState() => _SchedulePageMainState();
}

class _SchedulePageMainState extends State<SchedulePageMain> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HorizontalCalendar(
            focusedDate: _selectedDate,
            semester: '',
            activeWeekdays: ['su'],
          ),
        ],
      ),
    );
  }
}
