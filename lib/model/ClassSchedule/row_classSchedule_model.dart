import 'package:academicpanel/theme/style/tba_style.dart';

class RowClassscheduleModel {
  final String day;
  final String startTime;
  final String endTime;
  final String room;

  RowClassscheduleModel({
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.day,
  });

  factory RowClassscheduleModel.fromMap(
    Map<String, dynamic> map,
    String dayKey,
  ) {
    return RowClassscheduleModel(
      day: dayKey,
      room: TbaStyle.checkTBA(map['room']),
      startTime: TbaStyle.checkTBA(map['startTime']),
      endTime: TbaStyle.checkTBA(map['endTime']),
    );
  }
}
