import 'package:academicpanel/model/departmentSuperModel/row_announcement_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_departmentBaseData_model.dart';

class DepartmentModel {
  final List<RowAcademiccalendarModel>? academiccalendarModel;
  final List<RowAnnouncementModel>? announcementModel;
  final RowDepartmenBaseModel departmenBaseModel;

  DepartmentModel({
    this.academiccalendarModel,
    this.announcementModel,
    required this.departmenBaseModel,
  });
}
