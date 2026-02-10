import 'package:academicpanel/theme/style/tba_style.dart';

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
    return RowCourseModel(
      code: TbaStyle.checkTBA(map['code']),
      name: TbaStyle.checkTBA(map['name']),
      credit: (map['credit'] ?? 0).toDouble(),
    );
  }
}
