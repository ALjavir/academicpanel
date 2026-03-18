import 'package:academicpanel/theme/style/tba_style.dart';

class RowDepartmenBaseModel {
  final String whatsApp;
  final String currentSem;

  RowDepartmenBaseModel({required this.whatsApp, required this.currentSem});

  factory RowDepartmenBaseModel.fromMap(Map<String, dynamic> map) {
    return RowDepartmenBaseModel(
      whatsApp: TbaStyle.checkTBA(map['whatsApp']),
      currentSem: TbaStyle.checkTBA(map['current_sem']),
    );
  }
}
