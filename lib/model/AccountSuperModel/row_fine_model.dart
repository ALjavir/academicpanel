import 'package:academicpanel/theme/style/tba_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RowFineModel {
  final String code;
  final String name;
  final DateTime created_at;
  final double amount;
  RowFineModel({
    required this.code,
    required this.name,
    required this.created_at,
    required this.amount,
  });

  factory RowFineModel.fromMap(Map<String, dynamic> map) {
    return RowFineModel(
      code: TbaStyle.checkTBA(map['code']),
      name: TbaStyle.checkTBA(map['name']),
      created_at: (map['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      amount: (map['amount'] ?? 0).toDouble(),
    );
  }
}
