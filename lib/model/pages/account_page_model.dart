class AccountPageModel {
  final AccountPageModelTopHeader accountPageModelTopHeader;

  AccountPageModel({required this.accountPageModelTopHeader});
}

class AccountPageModelTopHeader {
  final double due;
  final double waiver;
  final double paid;
  final double balance;
  final double fine;
  final double totalDue;
  final double totalPaid;

  AccountPageModelTopHeader({
    required this.due,
    required this.waiver,
    required this.paid,
    required this.balance,
    required this.totalDue,
    required this.totalPaid,
    required this.fine,
  });
}
