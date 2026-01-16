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
      title: map['title'] ?? 'TBA',
      day: map['day'] ?? 'TBA',
      type: map['type'] ?? 'TBA',
      date: map['date'] ?? 'TBA',
    );
  }
}
