import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';

class ClassscheduleModel {
  final RowCourseModel course;
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
  });

  factory ClassscheduleModel.fromJoinedData({
    required Map<String, dynamic>? courseInfo, // From the Course Doc
    required Map<String, dynamic>? sectionData, // From the Section Doc
    required Map<String, dynamic>? daySchedule, // From the 'su'/'mo' map
    required String defaultCode, // Fallback if code is missing
  }) {
    final info = courseInfo ?? {};
    final sec = sectionData ?? {};
    final schedule = daySchedule ?? {};

    return ClassscheduleModel(
      // name: info['name'] ?? '',
      // code: info['code'] ?? defaultCode,
      instructor: sec['instructor'] ?? sec['instracter'] ?? 'TBA',
      room: schedule['room']?.toString() ?? 'TBA',
      startTime: schedule['startTime'] ?? 'TBA',
      endTime: schedule['endTime'] ?? 'TBA',
      course: RowCourseModel.fromMap(info),
    );
  }
}
