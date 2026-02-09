import 'package:academicpanel/model/Announcement/announcement_model.dart';

import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/departmentSuperModel/noClass_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_cgpacr_model.dart';

class HomePageModel {
  final HomeTopHeaderModel homeTopHeaderModel;
  final HomeTodayClassSchedule homeTodayClassSchedule;
  final HomeAccountModel homeAccountInfoModel;
  final RowCgpaCrModel homeRowCgpaModel;
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

class HomeAccountModel {
  final double totalDue;
  final double totalPaid;
  final double paidPercentage;
  final double balance;
  final InstallmentModel? upcomingInstallment;

  HomeAccountModel({
    required this.totalDue,
    required this.totalPaid,
    required this.paidPercentage,
    required this.balance,
    this.upcomingInstallment,
  });

  factory HomeAccountModel.fromMap(Map<String, dynamic> map) {
    return HomeAccountModel(
      balance: map['balance'] ?? 0,
      totalDue: map['totalDue'] ?? 0,
      totalPaid: map['totalPaid'] ?? 0,
      paidPercentage: map['paidPercentage'] ?? 0,
      upcomingInstallment: map['upcomingInstallment'] != null
          ? InstallmentModel.fromMap(map['upcomingInstallment'])
          : null,
    );
  }
}

class InstallmentModel {
  final String title;
  final String dueDate;
  final double fine;
  final double amount;

  InstallmentModel({
    required this.title,
    required this.fine,
    required this.dueDate,
    required this.amount,
  });
  factory InstallmentModel.fromMap(Map<String, dynamic> map) {
    return InstallmentModel(
      title: map['title'] ?? '',
      dueDate: map['dueDate'] ?? '',
      fine: (map['fine'] ?? 0).toDouble(),
      amount: (map['amount'] ?? 0).toDouble(),
    );
  }
}
