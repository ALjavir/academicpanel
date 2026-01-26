class RowCgpaModel {
  final double credit_completed;
  final double target_credit;
  final double credit_enrolled;
  final double pervious_cgpa;
  final double current_cgpa;
  final String comment;
  RowCgpaModel({
    required this.credit_completed,
    required this.target_credit,
    required this.credit_enrolled,
    required this.pervious_cgpa,
    required this.current_cgpa,
    required this.comment,
  });
  factory RowCgpaModel.fromMap(Map<String, dynamic> map) {
    return RowCgpaModel(
      comment: map['comment'] ?? '',
      credit_completed: (map['credit_completed'] ?? 0).toDouble(),
      target_credit: (map['target_credit'] ?? 0).toDouble(),
      credit_enrolled: (map['credit_enrolled'] ?? 0).toDouble(),

      pervious_cgpa: (map['pervious_cgpa'] ?? 0).toDouble(),

      current_cgpa: (map['current_cgpa'] ?? 0).toDouble(),
    );
  }
}
