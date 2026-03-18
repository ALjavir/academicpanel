import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadmix1() async {
  final String message =
      'Applications are open for Summer 2026 internships. Submit your CV by April 5';

  final DateTime created_at = DateTime(2026, 1, 12, 12, 00, 24);

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('department')
      .doc('CSE')
      .collection("announcement")
      .doc();

  //course/CSE/course_code/CHE101/section/3/assessment

  try {
    await docRef.set({
      'message': message,
      'created_at': Timestamp.fromDate(created_at),
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}

Future<void> uploadmix2() async {
  final String message =
      'Join the intra-department coding contest on March 25. Register now!';

  final DateTime created_at = DateTime(2026, 1, 7, 12, 00, 24);

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('department')
      .doc('CSE')
      .collection("announcement")
      .doc();

  //course/CSE/course_code/CHE101/section/3/assessment

  try {
    await docRef.set({
      'message': message,
      'created_at': Timestamp.fromDate(created_at),
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}

Future<void> uploadmix3() async {
  final String message =
      'Midterm exams will begin from April 10. Check the portal for details';

  final DateTime created_at = DateTime(2026, 1, 12, 12, 00, 24);

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('department')
      .doc('CSE')
      .collection("announcement")
      .doc();

  //course/CSE/course_code/CHE101/section/3/assessment

  try {
    await docRef.set({
      'message': message,
      'created_at': Timestamp.fromDate(created_at),
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}

Future<void> uploadmix4() async {
  final String message =
      'All computer labs will remain closed on March 20 due to maintenance.';

  final DateTime created_at = DateTime(2026, 1, 12, 12, 00, 24);

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('department')
      .doc('CSE')
      .collection("announcement")
      .doc();

  //course/CSE/course_code/CHE101/section/3/assessment

  try {
    await docRef.set({
      'message': message,
      'created_at': Timestamp.fromDate(created_at),
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}

Future<void> uploadmix5() async {
  final String message =
      'Final year students must submit thesis proposals by April 1';

  final DateTime created_at = DateTime(2026, 1, 12, 12, 00, 24);

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('department')
      .doc('CSE')
      .collection("announcement")
      .doc();

  //course/CSE/course_code/CHE101/section/3/assessment

  try {
    await docRef.set({
      'message': message,
      'created_at': Timestamp.fromDate(created_at),
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}
