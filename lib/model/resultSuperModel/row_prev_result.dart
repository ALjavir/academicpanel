import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';
import 'package:academicpanel/theme/style/tba_style.dart';

class RowPrevResult {
  // final String code;
  // final String name;
  final String grade;
  // final double credit;
  final RowCourseModel rowCourseModel;

  RowPrevResult({
    required this.grade,
    // required this.code,
    // required this.name,

    // required this.credit,
    required this.rowCourseModel,
  });

  factory RowPrevResult.fromMap(Map<String, dynamic> map) {
    return RowPrevResult(
      grade: TbaStyle.checkTBA(map['grade']),
      rowCourseModel: RowCourseModel.fromMap(map),
      // code: checkTBA(map['code']),
      // name: checkTBA(map['name']),

      // credit: (map['credit'] ?? 0).toDouble(),
    );
  }
}
