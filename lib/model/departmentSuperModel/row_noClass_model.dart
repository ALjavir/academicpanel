import 'package:cloud_firestore/cloud_firestore.dart';

class RowNoclassModel {
  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? type;

  RowNoclassModel({this.title, this.startDate, this.endDate, this.type});
  factory RowNoclassModel.fromJson(Map<String, dynamic> data) {
    return RowNoclassModel(
      title: data['title'] ?? 'TBA',
      type: data['type'] ?? 'TBA',
      startDate: (data['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (data['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
