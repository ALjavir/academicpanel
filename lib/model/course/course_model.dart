class CourseModel {
  final String code;
  final String name;
  final int credit;

  CourseModel({required this.code, required this.name, required this.credit});
  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      credit: map['credit'] ?? 0,
    );
  }
}
