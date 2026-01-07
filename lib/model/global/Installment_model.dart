class InstallmentModel {
  final String title;
  final String dueDate;
  final int fine;
  final int amount;

  InstallmentModel({
    required this.title,
    required this.fine,
    required this.dueDate,
    required this.amount,
  });
}
