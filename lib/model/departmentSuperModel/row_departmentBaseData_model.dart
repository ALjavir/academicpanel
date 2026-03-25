import 'package:academicpanel/theme/style/tba_style.dart';

class RowDepartmenBaseModel {
  final String name;
  final String department_id;
  final String whatsApp;
  final String currentSem;

  RowDepartmenBaseModel({
    required this.whatsApp,
    required this.currentSem,
    required this.name,
    required this.department_id,
  });

  factory RowDepartmenBaseModel.fromMap(Map<String, dynamic> map) {
    return RowDepartmenBaseModel(
      name: TbaStyle.checkTBA(map['name']),
      department_id: TbaStyle.checkTBA(map['department_id']),
      whatsApp: TbaStyle.checkTBA(map['whatsApp']),
      currentSem: TbaStyle.checkTBA(map['current_sem']),
    );
  }
}
