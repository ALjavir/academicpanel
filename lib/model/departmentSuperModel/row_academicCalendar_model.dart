import 'package:academicpanel/theme/style/tba_style.dart';

class RowAcademiccalendarModel {
  final String title;
  final String day;
  final String date;
  final String type;

  RowAcademiccalendarModel({
    required this.title,
    required this.day,
    required this.date,
    required this.type,
  });

  factory RowAcademiccalendarModel.fromMap(Map<String, dynamic> map) {
    return RowAcademiccalendarModel(
      title: TbaStyle.checkTBA(map['title']),
      day: TbaStyle.checkTBA(map['day']),
      type: TbaStyle.checkTBA(map['type']),
      date: TbaStyle.checkTBA(map['date']),
    );
  }
}
