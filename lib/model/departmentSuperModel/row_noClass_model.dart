import 'package:cloud_firestore/cloud_firestore.dart';

class RowNoclassModel {
  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? type;

  RowNoclassModel({this.title, this.startDate, this.endDate, this.type});
  factory RowNoclassModel.fromJson(Map<String, dynamic> data) {
    String checkTBA(dynamic value) {
      if (value == null || (value is String && value.trim().isEmpty)) {
        return 'TBA';
      }
      return value.toString();
    }

    return RowNoclassModel(
      title: checkTBA(data['title']),
      type: checkTBA(data['type']),
      startDate: (data['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (data['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
