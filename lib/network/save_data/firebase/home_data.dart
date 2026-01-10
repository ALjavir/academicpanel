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

  DocumentReference<Map<String, dynamic>> accountData(
    String department,
    String semester,
  ) {
    return FirebaseFirestore.instance
        .collection('accounts')
        .doc(department)
        .collection('semester')
        .doc(semester);
  }
}
//accounts/CSE/semester/Fall-25/student_id/222208038
//accounts/CSE/semester/Fall-2025/student_id/222208038