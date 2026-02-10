import 'package:academicpanel/theme/style/tba_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RowInstallmentModel {
  final DateTime deadline;
  final double amountPercentage;
  final double fine;
  final String code;
  final double amount;

  RowInstallmentModel({
    required this.deadline,
    required this.amountPercentage,
    required this.fine,
    required this.code,
    required this.amount,
  });

  factory RowInstallmentModel.fromMap(Map<String, dynamic> map) {
    return RowInstallmentModel(
      deadline: (map['deadline'] as Timestamp?)?.toDate() ?? DateTime.now(),
      amountPercentage: (map['amount_%'] ?? 0).toDouble(),
      fine: (map['fine'] ?? 0).toDouble(),
      code: TbaStyle.checkTBA(map['code']),
      amount: 0,
    );
  }
}
