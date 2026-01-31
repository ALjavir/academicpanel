import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';

class AssessmentResult {
  final RowCourseModel rowCourseModel;
  final List<AssessmentModel> quizList;
  final List<AssessmentModel> assignmentList;
  final AssessmentModel presentation;
  final AssessmentModel viva;
  final AssessmentModel midE;
  final AssessmentModel finalE;
  final double totalMark;
  final String grade;
  AssessmentResult({
    required this.quizList,
    required this.assignmentList,
    required this.presentation,
    required this.viva,
    required this.midE,
    required this.finalE,
    required this.totalMark,
    required this.grade,
    required this.rowCourseModel,
  });
}
