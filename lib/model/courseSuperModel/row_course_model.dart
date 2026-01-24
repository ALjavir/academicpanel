class RowCourseModel {
  final String code;
  final String name;
  final double credit;

  RowCourseModel({
    required this.code,
    required this.name,
    required this.credit,
  });
  factory RowCourseModel.fromMap(Map<String, dynamic> map) {
    String checkTBA(dynamic value) {
      if (value == null || (value is String && value.trim().isEmpty)) {
        return 'TBA';
      }
      return value.toString();
    }

    return RowCourseModel(
      code: checkTBA(map['code']),
      name: checkTBA(map['name']),
      credit: (map['credit'] ?? 0).toDouble(),
    );
  }
}
