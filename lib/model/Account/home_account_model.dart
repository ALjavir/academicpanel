class HomeAccountModel {
  final double totalDue;
  final double totalPaid;
  final double paidPercentage;
  final double balance;
  final InstallmentModel? upcomingInstallment;

  HomeAccountModel({
    required this.totalDue,
    required this.totalPaid,
    required this.paidPercentage,
    required this.balance,
    this.upcomingInstallment,
  });

  factory HomeAccountModel.fromMap(Map<String, dynamic> map) {
    return HomeAccountModel(
      balance: map['balance'] ?? 0,
      totalDue: map['totalDue'] ?? 0,
      totalPaid: map['totalPaid'] ?? 0,
      paidPercentage: map['paidPercentage'] ?? 0,
      upcomingInstallment: map['upcomingInstallment'] != null
          ? InstallmentModel.fromMap(map['upcomingInstallment'])
          : null,
    );
  }
}

class InstallmentModel {
  final String title;
  final String dueDate;
  final double fine;
  final double amount;

  InstallmentModel({
    required this.title,
    required this.fine,
    required this.dueDate,
    required this.amount,
  });
  factory InstallmentModel.fromMap(Map<String, dynamic> map) {
    return InstallmentModel(
      title: map['title'] ?? '',
      dueDate: map['dueDate'] ?? '',
      fine: (map['fine'] ?? 0).toDouble(),
      amount: (map['amount'] ?? 0).toDouble(),
    );
  }
}
