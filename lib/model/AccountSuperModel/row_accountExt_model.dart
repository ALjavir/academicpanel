class RowAccountextModel {
  final double perCreditFee;
  final double balance;
  final double waiver;

  RowAccountextModel({
    required this.perCreditFee,
    required this.balance,
    required this.waiver,
  });

  factory RowAccountextModel.fromMap(Map<String, dynamic> map) {
    return RowAccountextModel(
      perCreditFee: (map['per_credit'] ?? 0).toDouble(),
      balance: (map['balance'] ?? 0).toDouble(),
      waiver: (map['waver_%'] ?? 0).toDouble(),
    );
  }
}
