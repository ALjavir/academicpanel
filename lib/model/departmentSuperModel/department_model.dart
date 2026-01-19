import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_noClass_model.dart';

class DepartmentModel {
  final List<RowAcademiccalendarModel>? academiccalendarModel;
  final List<RowNoclassModel>? rowNoclassModel;
  DepartmentModel({this.academiccalendarModel, this.rowNoclassModel});
}
