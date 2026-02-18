import 'package:academicpanel/theme/style/tba_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RowFineModel {
  final String code;
  final double due;
  final DateTime created_at;
  final double amount;
  final double target;
  final double paid;
  RowFineModel({
    required this.code,
    required this.due,
    required this.created_at,
    required this.target,
    required this.paid,
    required this.amount,
  });

  factory RowFineModel.fromMap(Map<String, dynamic> map) {
    return RowFineModel(
      code: TbaStyle.checkTBA(map['code']),
      due: (map['due'] ?? 0).toDouble(),
      created_at: (map['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      target: (map['target'] ?? 0).toDouble(),
      paid: (map['paid'] ?? 0).toDouble(),
      amount: (map['amount'] ?? 0).toDouble(),
    );
  }
}
