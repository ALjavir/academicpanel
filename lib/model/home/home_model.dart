import 'package:academicpanel/model/global/Installment_model.dart';
import 'package:academicpanel/model/global/anouncement.dart';
import 'package:academicpanel/model/global/classSchedule_model.dart';

class HomeModel {
  final HomeTopHeaderModel homeTopHeaderModel;
  final List<ClassscheduleModel> homeTodayClassSchedule;
  final HomeAccountInfoModel homeAccountInfoModel;

  final List<Anouncement> homeAnouncement;
  HomeModel({
    required this.homeTopHeaderModel,
    required this.homeTodayClassSchedule,
    required this.homeAccountInfoModel,
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

class HomeAccountInfoModel {
  final int totalDue;
  final int totalPaid;
  final double paidPercentage;
  final InstallmentModel? upcomingInstallment;

  HomeAccountInfoModel({
    required this.totalDue,
    required this.totalPaid,
    required this.paidPercentage,
    this.upcomingInstallment,
  });
}
