import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_assessment_mark.dart';
import 'package:academicpanel/model/resultSuperModel/row_prev_result.dart';

class CurrentSemResultModel {
  final RowCourseModel rowCourseModel;
  final List<RowAssessmentMark> quizList;
  final List<RowAssessmentMark> assignmentList;
  final List<RowAssessmentMark> presentationList;
  final List<RowAssessmentMark> vivaList;
  final RowAssessmentMark midE;
  final RowAssessmentMark finalE;
  final double totalMark;
  final String grade;
  CurrentSemResultModel({
    required this.quizList,
    required this.assignmentList,
    required this.presentationList,
    required this.vivaList,
    required this.midE,
    required this.finalE,
    required this.totalMark,
    required this.grade,
    required this.rowCourseModel,
  });
}

class PrevSemResultResultPage {
  final String prevSemester;
  final List<dynamic> listPrevSem;
  final List<RowPrevResult> rowPrevResultList;
  PrevSemResultResultPage({
    required this.rowPrevResultList,
    required this.prevSemester,
    required this.listPrevSem,
  });
}
