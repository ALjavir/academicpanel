import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_assessment_mark.dart';

class CurrentSemResultModel {
  final RowCourseModel rowCourseModel;
  final List<RowAssessmentMark> quizList;
  final List<RowAssessmentMark> assignmentList;
  final RowAssessmentMark presentation;
  final RowAssessmentMark viva;
  final RowAssessmentMark midE;
  final RowAssessmentMark finalE;
  final double totalMark;
  final String grade;
  CurrentSemResultModel({
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
