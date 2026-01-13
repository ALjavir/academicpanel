import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';

class ClassscheduleModel {
  final RowCourseModel course;
  final String day; // "su", "mo", etc.
  final String startTime;
  final String endTime;
  final String room;
  final String instructor;

  ClassscheduleModel({
    required this.course,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.instructor,
    required this.day,
  });

  factory ClassscheduleModel.fromJoinedData({
    required Map<String, dynamic>? courseInfo,
    required Map<String, dynamic>? sectionData,
    required Map<String, dynamic>? daySchedule,
    required String defaultCode,
    required String dayKey, // <--- 1. ADD THIS ARGUMENT
  }) {
    final info = courseInfo ?? {};
    final sec = sectionData ?? {};
    final schedule = daySchedule ?? {};

    return ClassscheduleModel(
      // 2. Pass it to the model
      day: dayKey,
      instructor: sec['instructor'] ?? sec['instracter'] ?? 'TBA',
      room: schedule['room']?.toString() ?? 'TBA',
      startTime: schedule['startTime'] ?? 'TBA',
      endTime: schedule['endTime'] ?? 'TBA',

      // Make sure RowCourseModel handles empty 'name'/'code' safely internally
      course: RowCourseModel.fromMap(info),
    );
  }
}
