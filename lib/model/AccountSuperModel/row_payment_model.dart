import 'package:academicpanel/theme/style/tba_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RowPaymentModel {
  final String txid;
  final String method;
  final String from;
  final DateTime createdAt;
  final double amount;

  RowPaymentModel({
    required this.method,
    required this.from,
    required this.createdAt,
    required this.amount,
    required this.txid,
  });

  factory RowPaymentModel.fromMap(Map<String, dynamic> map) {
    return RowPaymentModel(
      method: TbaStyle.checkTBA(map['method']),
      from: TbaStyle.checkTBA(map['from']),
      createdAt: (map['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      amount: (map['amount'] ?? 0).toDouble(),
      txid: TbaStyle.checkTBA(map['txid']),
    );
  }
}
