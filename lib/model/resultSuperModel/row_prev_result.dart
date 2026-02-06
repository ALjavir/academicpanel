class RowPrevResult {
  final String code;
  final String name;
  final String grade;
  final double credit;

  RowPrevResult({
    required this.code,
    required this.name,
    required this.grade,
    required this.credit,
  });

  factory RowPrevResult.fromMap(Map<String, dynamic> map) {
    String checkTBA(dynamic value) {
      if (value == null || (value is String && value.trim().isEmpty)) {
        return 'TBA';
      }
      return value.toString();
    }

    return RowPrevResult(
      code: checkTBA(map['code']),
      name: checkTBA(map['name']),
      grade: checkTBA(map['grade']),
      credit: (map['credit'] ?? 0).toDouble(),
    );
  }
}
