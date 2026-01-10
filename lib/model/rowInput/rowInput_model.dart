class StudentAccountRawData {
  final double due;
  final double paid;
  final double totalFine;
  final double waver_;
  final double balance;

  StudentAccountRawData({
    required this.due,
    required this.paid,
    required this.totalFine,
    required this.waver_,
    required this.balance,
  });

  factory StudentAccountRawData.fromMap(Map<String, dynamic> map) {
    return StudentAccountRawData(
      due: (map['due'] ?? 0).toDouble(),
      paid: (map['paid'] ?? 0).toDouble(),
      totalFine: (map['totalFine'] ?? 0).toDouble(),
      waver_: (map['waver_%'] ?? 0).toDouble(),
      balance: (map['balance'] ?? 0).toDouble(),
    );
  }
}
