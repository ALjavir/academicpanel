class RowAccounbaseModel {
  final double perCreditFee;
  final double balance;
  final int waiver;

  RowAccounbaseModel({
    required this.perCreditFee,
    required this.balance,
    required this.waiver,
  });

  factory RowAccounbaseModel.fromMap(Map<String, dynamic> map) {
    return RowAccounbaseModel(
      perCreditFee: (map['per_credit'] ?? 0).toDouble(),
      balance: (map['balance'] ?? 0).toDouble(),
      waiver: map['waver_%'] ?? 0,
    );
  }
}
