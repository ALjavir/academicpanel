import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class FirebaseDatapath extends GetxController {
  DocumentReference<Map<String, dynamic>> userData(
    String department,
    String roleID,
    String id,
  ) {
    return FirebaseFirestore.instance
        .collection('profile')
        .doc(department)
        .collection(roleID)
        .doc(id);
  }

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

  DocumentReference<Map<String, dynamic>> resultData(
    String department,
    String student_id,
  ) {
    return FirebaseFirestore.instance
        .collection('result')
        .doc(department)
        .collection('student_id')
        .doc(student_id);
  }

  DocumentReference<Map<String, dynamic>> departmentData(String department) {
    return FirebaseFirestore.instance.collection('department').doc(department);
  }
}
