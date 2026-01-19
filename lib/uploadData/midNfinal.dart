import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadmix() async {
  final String assessment = 'mid';

  final DateTime startTime = DateTime(2026, 2, 5, 12, 00, 24);
  final DateTime endTime = DateTime(2026, 2, 5, 13, 10, 52);

  final String room = '413';
  final int mark = 30;

  final String link = '';
  final String syllabus = '';

  final List<String> instructor = ['EThomas', 'MiaM'];

  final Map<String, int> result = {'222208038': 222208038};

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('course')
      .doc('CSE')
      .collection('course_code')
      .doc('CSE101')
      .collection("section")
      .doc('1')
      .collection("assessment")
      .doc();

  //course/CSE/course_code/CHE101/section/3/assessment

  try {
    await docRef.set({
      'assessment': assessment,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'room': room,
      'mark': mark,
      'link': link,
      'syllabus': syllabus,
      'instructor': instructor,
      'result': result,
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}
