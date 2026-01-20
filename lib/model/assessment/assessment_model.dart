import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';

class AssessmentModel {
  final String assessment;
  final DateTime startTime;
  final DateTime endTime;
  final String link;
  final String room;
  final String syllabus;
  final double result;
  final List<String> instructor;
  final RowCourseModel rowCourseModel;
  AssessmentModel({
    required this.result,
    required this.assessment,
    required this.rowCourseModel,
    required this.link,
    required this.syllabus,
    required this.startTime,
    required this.endTime,
    required this.instructor,
    required this.room,
  });
}
