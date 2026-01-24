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
    String checkTBA(dynamic value) {
      if (value == null || (value is String && value.trim().isEmpty)) {
        return 'TBA';
      }
      return value.toString();
    }

    return RowAcademiccalendarModel(
      title: checkTBA(map['title']),
      day: checkTBA(map['day']),
      type: checkTBA(map['type']),
      date: checkTBA(map['date']),
    );
  }
}
