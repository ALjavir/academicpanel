import 'package:academicpanel/theme/style/tba_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RowNoclassModel {
  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? type;

  RowNoclassModel({this.title, this.startDate, this.endDate, this.type});
  factory RowNoclassModel.fromJson(Map<String, dynamic> data) {
    return RowNoclassModel(
      title: TbaStyle.checkTBA(data['title']),
      type: TbaStyle.checkTBA(data['type']),
      startDate: (data['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (data['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
