import 'package:academicpanel/model/assessment/row_assessment_model.dart';
import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';

class AssessmentModel {
  final RowAssessmentModel rowAssessmentModel;
  final RowCourseModel rowCourseModel;
  final String gClassRoom;
  AssessmentModel({
    required this.rowAssessmentModel,
    required this.rowCourseModel,
    required this.gClassRoom,
  });
}
