import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RowAcStatementModel {
  final double amount;
  final DateTime createdAt;
  final RowCourseModel rowCourseModel;

  RowAcStatementModel({
    required this.amount,
    required this.createdAt,
    required this.rowCourseModel,
  });

  factory RowAcStatementModel.fromMap(Map<String, dynamic> map) {
    return RowAcStatementModel(
      amount: (map['amount'] ?? 0).toDouble(),
      createdAt: (map['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      rowCourseModel: .fromMap(map),
    );
  }
}
