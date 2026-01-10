import 'package:cloud_firestore/cloud_firestore.dart';

class RowAccountModel {
  final double due;
  final double paid;
  final double totalFine;
  final double waver_;
  final double balance;

  RowAccountModel({
    required this.due,
    required this.paid,
    required this.totalFine,
    required this.waver_,
    required this.balance,
  });

  factory RowAccountModel.fromMap(Map<String, dynamic> map) {
    return RowAccountModel(
      due: (map['due'] ?? 0).toDouble(),
      paid: (map['paid'] ?? 0).toDouble(),
      totalFine: (map['totalFine'] ?? 0).toDouble(),
      waver_: (map['waver_%'] ?? 0).toDouble(),
      balance: (map['balance'] ?? 0).toDouble(),
    );
  }
}

class RoeInstallmentModel {
  final DateTime? deadline; // Store as DateTime for logic!
  final double amount_; // Renamed for clarity (was amount_)
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
