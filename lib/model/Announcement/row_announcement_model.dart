import 'package:academicpanel/theme/style/tba_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RowAnnouncementModel {
  final String message;
  final DateTime date;

  RowAnnouncementModel({required this.message, required this.date});

  factory RowAnnouncementModel.fromMap(Map<String, dynamic> map) {
    return RowAnnouncementModel(
      message: TbaStyle.checkTBA(map['message']),

      date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
