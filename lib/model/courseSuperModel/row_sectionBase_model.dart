import 'package:academicpanel/theme/style/tba_style.dart';

class RowSectionbaseModel {
  final Map<String, dynamic> scheduleMap;
  final String instructor;
  final String whatsApp;
  final String gClassRoom;

  RowSectionbaseModel({
    required this.scheduleMap,
    required this.instructor,
    required this.whatsApp,
    required this.gClassRoom,
  });
  factory RowSectionbaseModel.fromMap(Map<String, dynamic> map) {
    return RowSectionbaseModel(
      whatsApp: TbaStyle.checkTBA(map['whatsApp']),
      instructor: TbaStyle.checkTBA(map['instructor']),
      scheduleMap: map['schedule'] ?? {},
      gClassRoom: TbaStyle.checkTBA(map['gClassRoom']),
    );
  }
}
