import 'package:flutter/material.dart';

class AcademicCalendarPage extends StatelessWidget {
  const AcademicCalendarPage({super.key});

  // Data from your PDF (Hardcoded for now, or fetch from JSON)
  final List<Map<String, String>> events = const [
    {
      "date": "07 Jan",
      "day": "Wed",
      "title": "Spring 2026 Trimester Starts",
      "type": "start",
    },
    {
      "date": "08-12 Jan",
      "day": "Thu-Mon",
      "title": "Advising/Registration (Day/Evening)",
      "type": "reg",
    },
    {
      "date": "09-16 Jan",
      "day": "Fri-Fri",
      "title": "Advising/Registration (Weekend)",
      "type": "reg",
    },
    {
      "date": "17 Jan",
      "day": "Sat",
      "title": "Holiday: Shab-e-Meraj",
      "type": "holiday",
    },
    {
      "date": "19 Jan",
      "day": "Mon",
      "title": "Late Registration Starts",
      "type": "deadline",
    },
    {
      "date": "15 Feb",
      "day": "Sun",
      "title": "1st Installment Payment (50%)",
      "type": "payment",
    },
    {
      "date": "21 Feb",
      "day": "Sat",
      "title": "Holiday: Intl. Mother Language Day",
      "type": "holiday",
    },
    {
      "date": "27 Feb - 08 Mar",
      "day": "Fri-Sun",
      "title": "Midterm Exam Period",
      "type": "exam",
    },
    {
      "date": "13 Mar",
      "day": "Fri",
      "title": "2nd Installment Payment (30%)",
      "type": "payment",
    },
    {
      "date": "26 Mar",
      "day": "Thu",
      "title": "Holiday: Independence Day",
      "type": "holiday",
    },
    {
      "date": "10-24 Apr",
      "day": "Fri-Fri",
      "title": "Final Exam (Weekend)",
      "type": "exam",
    },
    {
      "date": "18-27 Apr",
      "day": "Sat-Mon",
      "title": "Final Exam (Day/Evening)",
      "type": "exam",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Academic Calendar",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return TimelineTile(
            date: event['date']!,
            day: event['day']!,
            title: event['title']!,
            type: event['type']!,
            isLast: index == events.length - 1,
          );
        },
      ),
    );
  }
}

class TimelineTile extends StatelessWidget {
  final String date;
  final String day;
  final String title;
  final String type;
  final bool isLast;

  const TimelineTile({
    super.key,
    required this.date,
    required this.day,
    required this.title,
    required this.type,
    this.isLast = false,
  });

  Color _getColor() {
    switch (type) {
      case 'holiday':
        return Colors.red;
      case 'exam':
        return Colors.purple;
      case 'payment':
        return Colors.orange;
      case 'reg':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Date Column
          SizedBox(
            width: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  day,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 20), // Spacing
              ],
            ),
          ),

          const SizedBox(width: 12),

          // 2. The Vertical Line & Dot
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _getColor(),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: _getColor().withOpacity(0.3),
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: Colors.grey.shade200),
                ),
            ],
          ),

          const SizedBox(width: 12),

          // 3. The Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
