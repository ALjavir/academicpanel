// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';

class RowAssessmentModel {
  final String assessment;
  final DateTime startTime;
  final DateTime endTime;
  final String room;
  final int mark;
  final String link;
  final String syllabus;
  final List<String> instructor;
  final double result;

  RowAssessmentModel({
    required this.assessment,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.mark,
    required this.link,
    required this.syllabus,
    required this.instructor,
    required this.result,
  });

  factory RowAssessmentModel.fromJson(
    Map<String, dynamic> data,
    String studentId,
  ) {
    final allResults = data['result'] as Map<String, dynamic>?;
    dynamic myScoreRaw = allResults != null ? allResults[studentId] : 0;
    return RowAssessmentModel(
      assessment: data['assessment'] ?? 'TBA',
      startTime: (data['startTime'] as Timestamp?)?.toDate() ?? DateTime.now(),

      endTime: (data['endTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      room: data['room'] ?? 'TBA',
      mark: (data['mark'] ?? 0).toInt(),
      link: data['link'] ?? 'TBA',
      syllabus: data['syllabus'] ?? 'TBA',
      instructor: List<String>.from(data['instructor'] ?? ['TBA • TBA']),
      result: (myScoreRaw ?? 0).toDouble(),
    );
  }
}
