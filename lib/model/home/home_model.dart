class HomeModel {
  final HomeTopHeaderModel homeTopHeaderModel;
  final TodayClassSchedule todayClassSchedule;
  HomeModel({
    required this.homeTopHeaderModel,
    required this.todayClassSchedule,
  });
}

class HomeTopHeaderModel {
  final String lastName;
  final String? image;
  final String date;
  final String semester;
  HomeTopHeaderModel({
    required this.lastName,
    this.image,
    required this.date,
    required this.semester,
  });
}

class TodayClassSchedule {
  final List<ClassTimeInfo>? classTimeInfo;
  TodayClassSchedule({this.classTimeInfo});
}

class ClassTimeInfo {
  final String name;
  final String code;
  final String startTime;
  final String endTime;
  final String room;
  final String instracter;
  ClassTimeInfo({
    required this.name,
    required this.code,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.instracter,
  });
}
