import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';

class AssessmentModel {
  final String assessment;
  final DateTime date;
  final String link;
  final String syllabus;
  final RowCourseModel rowCourseModel;
  AssessmentModel({
    required this.assessment,
    required this.date,
    required this.rowCourseModel,
    required this.link,
    required this.syllabus,
  });
}
