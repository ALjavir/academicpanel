import 'package:cloud_firestore/cloud_firestore.dart';

class RowAccountModel {
  final double ac_statementTotal;
  final double paidTotal;

  final double totalFine;
  final double waver_;
  final double balance;

  RowAccountModel({
    required this.ac_statementTotal,
    required this.paidTotal,

    required this.totalFine,
    required this.waver_,
    required this.balance,
  });

  factory RowAccountModel.fromMap(Map<String, dynamic> map) {
    double ac_statementTotal = 0;
    final statementMap = map['ac_statement'] as Map<String, dynamic>?;

    if (statementMap != null) {
      statementMap.forEach((key, value) {
        // value is the map like {amount: 7500, created_at...}
        if (value is Map<String, dynamic>) {
          ac_statementTotal += (value['amount'] ?? 0).toDouble();
        }
      });
    }

    // --- 2. CALCULATE TOTAL PAID (from payments list) ---
    double paidTotal = 0;
    final paymentsList = map['payments'] as List<dynamic>?;

    if (paymentsList != null) {
      for (var payment in paymentsList) {
        // payment is {amount: 2000, date: ...}
        if (payment is Map<String, dynamic>) {
          paidTotal += (payment['amount'] ?? 0).toDouble();
        }
      }
    }
    return RowAccountModel(
      ac_statementTotal: ac_statementTotal,
      paidTotal: paidTotal,
      totalFine: (map['totalFine'] ?? 0).toDouble(),
      waver_: (map['waver_%'] ?? 0).toDouble(),
      balance: (map['balance'] ?? 0).toDouble(),
    );
  }
}

class RoeInstallmentModel {
  final DateTime? deadline;
  final double amount_;
  final double fine;

  RoeInstallmentModel({
    required this.deadline,
    required this.amount_,
    required this.fine,
  });

  factory RoeInstallmentModel.fromMap(Map<String, dynamic> map) {
    DateTime? dateObj;

    // 1. Safe Conversion: Timestamp -> DateTime
    if (map['deadline'] is Timestamp) {
      dateObj = (map['deadline'] as Timestamp).toDate();
    }

    return RoeInstallmentModel(
      deadline: dateObj,
      // 2. Get the percentage directly (e.g., 50)
      amount_: (map['amount_%'] ?? 0).toDouble(),
      fine: (map['fine'] ?? 0).toDouble(),
    );
  }
}
