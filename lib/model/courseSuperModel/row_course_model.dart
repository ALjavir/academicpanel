class RowCourseModel {
  final String code;
  final String name;
  final int credit;

  RowCourseModel({
    required this.code,
    required this.name,
    required this.credit,
  });
  factory RowCourseModel.fromMap(Map<String, dynamic> map) {
    return RowCourseModel(
      code: map['code'] ?? 'TBA',
      name: map['name'] ?? 'TBA',
      credit: map['credit'] ?? 0,
    );
  }
}
