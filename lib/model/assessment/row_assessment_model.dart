import 'package:cloud_firestore/cloud_firestore.dart';

class RowAssessmentModel {
  final String assessment;
  final DateTime date;
  final String link;
  final int mark;
  final double result;
  final String syllabus;

  RowAssessmentModel({
    required this.assessment,
    required this.date,
    required this.link,
    required this.mark,
    required this.result,
    required this.syllabus,
  });

  // 1. Update Factory to accept 'studentId'
  factory RowAssessmentModel.fromMap(
    Map<String, dynamic> map,
    String studentId,
  ) {
    // 2. Extract the Result Map safely
    final allResults = map['result'] as Map<String, dynamic>?;
    // 3. Find MY score using my ID
    dynamic myScoreRaw = allResults != null ? allResults[studentId] : 0;
    return RowAssessmentModel(
      assessment: map['assessment'] ?? 'TBA',
      date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),

      mark: (map['mark'] ?? 0).toInt(),
      syllabus: map['syllabus'] ?? 'TBA',
      link: map['link'] ?? 'TBA',
      result: (myScoreRaw ?? 0).toDouble(),
    );
  }
}
