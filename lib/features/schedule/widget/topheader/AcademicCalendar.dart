import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:flutter/material.dart';

void showCalendarDialog(
  BuildContext context,
  List<RowAcademiccalendarModel> events,
) {
  showDialog(
    context: context,
    builder: (context) {
      print("In side the show dialog-------------------------------------");
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          // Limit height to 80% of screen so it doesn't overflow
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Use minimum height needed
            children: [
              // --- Header ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Academic Calendar",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),

              // --- The List ---
              // Wrapped in Expanded so it scrolls properly inside the constraints
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true, // Okay inside Column+Expanded
                  // REMOVED: physics: NeverScrollableScrollPhysics(), (We want it to scroll!)
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return TimelineTile(
                      date: event.date,
                      day: event.day,
                      title: event.title,
                      type: event.type,
                      isLast: index == events.length - 1,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
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

// class AcademicCalendarPage extends StatelessWidget {
//   final SchedulePageContoller schedulePageContoller;
//   const AcademicCalendarPage({super.key, required this.schedulePageContoller});

//   // Data from your PDF (Hardcoded for now, or fetch from JSON)
//   @override
//   @override
//   Widget build(BuildContext context) {
//     final futureEvents = schedulePageContoller.fetchAcademicCalendar();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: FutureBuilder<List<RowAcademiccalendarModel>>(
//         future: futureEvents,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text("No academic events found."));
//           }

//           final events = snapshot.data!;

//           return ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             padding: const EdgeInsets.all(16),
//             itemCount: events.length,
//             itemBuilder: (context, index) {
//               final event = events[index];
//               return TimelineTile(
//                 date: event.date,
//                 day: event.day,
//                 title: event.title,
//                 type: event.type,
//                 isLast: index == events.length - 1,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class TimelineTile extends StatelessWidget {
//   final String date;
//   final String day;
//   final String title;
//   final String type;
//   final bool isLast;

//   const TimelineTile({
//     super.key,
//     required this.date,
//     required this.day,
//     required this.title,
//     required this.type,
//     this.isLast = false,
//   });

//   Color _getColor() {
//     switch (type) {
//       case 'holiday':
//         return Colors.red;
//       case 'exam':
//         return Colors.purple;
//       case 'payment':
//         return Colors.orange;
//       case 'reg':
//         return Colors.blue;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IntrinsicHeight(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // 1. Date Column
//           SizedBox(
//             width: 70,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   date,
//                   textAlign: TextAlign.right,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 Text(
//                   day,
//                   textAlign: TextAlign.right,
//                   style: const TextStyle(color: Colors.grey, fontSize: 12),
//                 ),
//                 const SizedBox(height: 20), // Spacing
//               ],
//             ),
//           ),

//           const SizedBox(width: 12),

//           // 2. The Vertical Line & Dot
//           Column(
//             children: [
//               Container(
//                 width: 12,
//                 height: 12,
//                 decoration: BoxDecoration(
//                   color: _getColor(),
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 2),
//                   boxShadow: [
//                     BoxShadow(
//                       color: _getColor().withOpacity(0.3),
//                       blurRadius: 4,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//               ),
//               if (!isLast)
//                 Expanded(
//                   child: Container(width: 2, color: Colors.grey.shade200),
//                 ),
//             ],
//           ),

//           const SizedBox(width: 12),

//           // 3. The Content Card
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 24),
//               child: Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade100),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.shade100,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         title,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
