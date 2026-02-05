import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> result() async {
  final String code = 'CSE-206';
  final double credit = 1.00;
  final String grade = 'A';
  final String name = 'Object Oriented Programming Laboratory';
  final int point = 4;
  final int section = 1;
  final double totalMarks = 75.0;

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('result')
      .doc('CSE')
      .collection('student_id')
      .doc('222208038')
      .collection("Fall-24")
      .doc('CSE206');

  try {
    await docRef.set({
      'code': code,
      'credit': credit,
      'grade': grade,
      'name': name,
      'point': point,
      'section': section,
      'totalMarks': totalMarks,
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}

Future<void> result1() async {
  final String code = 'CSE-207';
  final double credit = 3.00;
  final String grade = 'A+';
  final String name = 'Digital Logic Design';
  final int point = 4;
  final int section = 1;
  final double totalMarks = 88.0;

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('result')
      .doc('CSE')
      .collection('student_id')
      .doc('222208038')
      .collection("Fall-24")
      .doc('CSE207');

  try {
    await docRef.set({
      'code': code,
      'credit': credit,
      'grade': grade,
      'name': name,
      'point': point,
      'section': section,
      'totalMarks': totalMarks,
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}

Future<void> result2() async {
  final String code = 'CSE-211';
  final double credit = 1.00;
  final String grade = 'A+';
  final String name = 'Data Structures and Algorithms';
  final int point = 4;
  final int section = 1;
  final double totalMarks = 85.0;

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('result')
      .doc('CSE')
      .collection('student_id')
      .doc('222208038')
      .collection("Fall-24")
      .doc('CSE211');

  try {
    await docRef.set({
      'code': code,
      'credit': credit,
      'grade': grade,
      'name': name,
      'point': point,
      'section': section,
      'totalMarks': totalMarks,
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}

Future<void> result3() async {
  final String code = 'CSE-212';
  final double credit = 1.00;
  final String grade = 'A';
  final String name = 'Data Structures and Algorithms Laboratory';
  final int point = 4;
  final int section = 3;
  final double totalMarks = 88.0;

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('result')
      .doc('CSE')
      .collection('student_id')
      .doc('222208038')
      .collection("Fall-24")
      .doc('CSE212');

  try {
    await docRef.set({
      'code': code,
      'credit': credit,
      'grade': grade,
      'name': name,
      'point': point,
      'section': section,
      'totalMarks': totalMarks,
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}

Future<void> result4() async {
  final String code = 'ENG-215';
  final double credit = 3.00;
  final String grade = 'A+';
  final String name = 'Professional English Communication';
  final int point = 4;
  final int section = 2;
  final double totalMarks = 98.0;

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('result')
      .doc('CSE')
      .collection('student_id')
      .doc('222208038')
      .collection("Fall-24")
      .doc('ENG215');

  try {
    await docRef.set({
      'code': code,
      'credit': credit,
      'grade': grade,
      'name': name,
      'point': point,
      'section': section,
      'totalMarks': totalMarks,
    });
    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
  }
}
