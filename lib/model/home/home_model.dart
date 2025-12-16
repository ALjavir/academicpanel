class HomeModel {
  final HomeTopHeaderModel homeTopHeaderModel;
  final TodayClass todayClass;
  HomeModel({required this.homeTopHeaderModel, required this.todayClass});
}

class HomeTopHeaderModel {
  final String lastName;
  final String? image;
  HomeTopHeaderModel({required this.lastName, this.image});
}

class TodayClass {
  final List<ClassTime>? classTime;
  TodayClass({this.classTime});
}

class ClassTime {
  final String name;
  final String code;
  final String time;
  final String room;
  final String instracter;
  ClassTime({
    required this.name,
    required this.code,
    required this.time,
    required this.room,
    required this.instracter,
  });
}
