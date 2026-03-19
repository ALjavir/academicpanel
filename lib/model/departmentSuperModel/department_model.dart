import 'package:academicpanel/model/Announcement/announcement_model.dart';

import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_departmentBaseData_model.dart';

class DepartmentModel {
  final List<RowAcademiccalendarModel>? academiccalendarModel;
  final List<AnnouncementModel>? announcementModel;
  final RowDepartmenBaseModel departmenBaseModel;

  DepartmentModel({
    this.academiccalendarModel,
    this.announcementModel,
    required this.departmenBaseModel,
  });
}
