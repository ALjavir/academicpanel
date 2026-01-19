import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
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
