import 'package:academicpanel/model/ClassSchedule/row_classSchedule_model.dart';
import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';

class ClassscheduleModel {
  final RowClassscheduleModel rowClassscheduleModel;
  final RowCourseModel rowCourseModel;
  final String instructor;

  ClassscheduleModel({
    required this.rowClassscheduleModel,
    required this.rowCourseModel,
    required this.instructor,
  });
}
