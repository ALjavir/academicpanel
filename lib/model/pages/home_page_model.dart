import 'package:academicpanel/model/Account/home_account_model.dart';
import 'package:academicpanel/model/Announcement/announcement_model.dart';

import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/departmentSuperModel/noClass_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_cgpa_model.dart';

class HomePageModel {
  final HomeTopHeaderModel homeTopHeaderModel;
  final HomeTodayClassSchedule homeTodayClassSchedule;
  final HomeAccountModel homeAccountInfoModel;
  final RowCgpaModel homeRowCgpaModel;
  final List<AnnouncementModel> homeAnouncement;
  final List<AssessmentModel> homeAssessment;
  HomePageModel({
    required this.homeTopHeaderModel,
    required this.homeTodayClassSchedule,
    required this.homeAccountInfoModel,
    required this.homeRowCgpaModel,
    required this.homeAnouncement,
    required this.homeAssessment,
  });
}

class HomeTopHeaderModel {
  final String lastName;
  final String? image;
  final String date;
  final String semester;
  HomeTopHeaderModel({
    required this.lastName,
    this.image,
    required this.date,
    required this.semester,
  });
}

class HomeTodayClassSchedule {
  NoclassModel? noclassModel;
  List<ClassscheduleModel>? listClassScheduleModel;
  HomeTodayClassSchedule({this.noclassModel, this.listClassScheduleModel});
}
