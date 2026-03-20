import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadmix1() async {
  final String message = 'Assignment submission today';

  final DateTime created_at = DateTime(2026, 1, 12, 12, 00, 24);

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('course')
      .doc('CSE')
      .collection('course_code')
      .doc('CHE101')
      .collection("section")
      .doc('3')
      .collection("announcement")
      .doc();

  //course/CSE/course_code/CHE101/section/3/assessment

  try {
    await docRef.set({
      'message': message,
      'createdAt': Timestamp.fromDate(created_at),
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}

Future<void> uploadmix2() async {
  final String message = 'Assignment 3 deadline extended';

  final DateTime created_at = DateTime(2026, 1, 7, 12, 00, 24);

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('course')
      .doc('CSE')
      .collection('course_code')
      .doc('CHE101')
      .collection("section")
      .doc('3')
      .collection("announcement")
      .doc();

  //course/CSE/course_code/CHE101/section/3/assessment

  try {
    await docRef.set({
      'message': message,
      'createdAt': Timestamp.fromDate(created_at),
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}

Future<void> uploadmix3() async {
  final String message = 'No late submission wii be aceptable for assignment 2';

  final DateTime created_at = DateTime(2026, 1, 12, 12, 00, 24);

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('course')
      .doc('CSE')
      .collection('course_code')
      .doc('CHE101')
      .collection("section")
      .doc('3')
      .collection("announcement")
      .doc();

  //course/CSE/course_code/CHE101/section/3/assessment

  try {
    await docRef.set({
      'message': message,
      'createdAt': Timestamp.fromDate(created_at),
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}

Future<void> uploadmix4() async {
  final String message = 'Tommorow class will be held online';

  final DateTime created_at = DateTime(2026, 1, 12, 12, 00, 24);

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('course')
      .doc('CSE')
      .collection('course_code')
      .doc('CHE101')
      .collection("section")
      .doc('3')
      .collection("announcement")
      .doc();

  //course/CSE/course_code/CHE101/section/3/assessment

  try {
    await docRef.set({
      'message': message,
      'createdAt': Timestamp.fromDate(created_at),
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}
