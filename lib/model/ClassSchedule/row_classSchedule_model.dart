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
    String checkTBA(dynamic value) {
      if (value == null || (value is String && value.trim().isEmpty)) {
        return 'TBA';
      }
      return value.toString();
    }

    return RowClassscheduleModel(
      day: dayKey,
      room: checkTBA(map['room']),
      startTime: checkTBA(map['startTime']),
      endTime: checkTBA(map['endTime']),
    );
  }
}
