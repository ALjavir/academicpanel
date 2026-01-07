import 'package:cloud_firestore/cloud_firestore.dart';

class HomeData {
  DocumentReference<Map<String, dynamic>> courseData(
    String department,
    String courseCode,
  ) {
    return FirebaseFirestore.instance
        .collection('course')
        .doc(department)
        .collection('course_code')
        .doc(courseCode);
  }
}
