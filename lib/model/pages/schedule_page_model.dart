import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/departmentSuperModel/noClass_model.dart';

class ClassSchedulePageSchedule {
  final List<String> days;
  final List<ClassscheduleModel> classSchedule;
  NoclassModel? noClass;
  ClassSchedulePageSchedule({
    required this.days,
    required this.classSchedule,
    this.noClass,
  });
}

class AssessmentPageSchedule {
  final List<String> courseCode;
  final List<AssessmentModel> assessmentModel;
  AssessmentPageSchedule({
    required this.courseCode,
    required this.assessmentModel,
  });
}

class ExamPageSchedule {
  final List<AssessmentModel> midExam;
  final List<AssessmentModel> finalExam;

  ExamPageSchedule({required this.midExam, required this.finalExam});
}
