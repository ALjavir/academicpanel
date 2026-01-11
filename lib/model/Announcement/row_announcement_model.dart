import 'package:cloud_firestore/cloud_firestore.dart';

class RowAnnouncementModel {
  final String message;
  final DateTime date;

  RowAnnouncementModel({required this.message, required this.date});
  factory RowAnnouncementModel.fromMap(Map<String, dynamic> map, String code) {
    return RowAnnouncementModel(
      message: map['message'] ?? '',

      date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
