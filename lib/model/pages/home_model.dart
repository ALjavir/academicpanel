import 'package:academicpanel/model/Account/home_account_model.dart';
import 'package:academicpanel/model/Announcement/announcement_model.dart';

import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/result/row_cgpa_model.dart';

class HomeModel {
  final HomeTopHeaderModel homeTopHeaderModel;
  final List<ClassscheduleModel> homeTodayClassSchedule;
  final HomeAccountModel homeAccountInfoModel;
  final RowCgpaModel homeRowCgpaModel;
  final List<AnnouncementModel> homeAnouncement;
  HomeModel({
    required this.homeTopHeaderModel,
    required this.homeTodayClassSchedule,
    required this.homeAccountInfoModel,
    required this.homeRowCgpaModel,
    required this.homeAnouncement,
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
