import 'package:academicpanel/theme/style/tba_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RowAcademiccalendarModel {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String type;

  RowAcademiccalendarModel({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.type,
  });
  factory RowAcademiccalendarModel.fromJson(Map<String, dynamic> data) {
    return RowAcademiccalendarModel(
      title: TbaStyle.checkTBA(data['title']),
      type: TbaStyle.checkTBA(data['type']),
      startDate: (data['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (data['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
