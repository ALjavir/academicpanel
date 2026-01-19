import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadacademi() async {
  // 1. The Data List (Clean List of Objects)
  final List<Map<String, dynamic>> rawData = [
    // --- HOLIDAYS ---
    {
      "title": "Shab-e-Meraj",
      "startDate": DateTime.parse("2026-01-17T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-01-17T00:00:00+06:00"),
      'type': 'Holiday',
    },
    {
      "title": "Shab-e-Barat",
      "startDate": DateTime.parse("2026-02-04T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-02-04T00:00:00+06:00"),
      'type': 'Holiday',
    },
    {
      "title": "Start of Holy Ramadan",
      "startDate": DateTime.parse("2026-02-18T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-02-18T00:00:00+06:00"),
      'type': 'Holiday',
    },
    {
      "title": "Intl Mother Language Day",
      "startDate": DateTime.parse("2026-02-21T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-02-21T00:00:00+06:00"),
      'type': 'Holiday',
    },
    {
      "title": "Shab-e-Qadar",
      "startDate": DateTime.parse("2026-03-17T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-03-17T00:00:00+06:00"),
      'type': 'Holiday',
    },
    {
      "title": "Jummatul-Bida & Eid-ul-Fitr",
      "startDate": DateTime.parse("2026-03-18T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-03-25T00:00:00+06:00"),
      'type': 'Holiday',
    },
    {
      "title": "Holiday: Independence Day",
      "startDate": DateTime.parse("2026-03-26T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-03-26T00:00:00+06:00"),
    },
    {
      "title": "Bangla New Year",
      "startDate": DateTime.parse("2026-04-14T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-04-14T00:00:00+06:00"),
      'type': 'Holiday',
    },
    {
      "title": "May Day & Buddha Purnima",
      "startDate": DateTime.parse("2026-05-01T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-05-01T00:00:00+06:00"),
      'type': 'Holiday',
    },
    {
      "title": "Semester Break",
      "startDate": DateTime.parse("2026-05-02T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-05-03T00:00:00+06:00"),
      'type': 'Holiday',
    },

    // --- EXAMS ---
    {
      "title": "Mid", // Originally: "Midterm Exam Period"
      "startDate": DateTime.parse("2026-02-27T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-03-08T00:00:00+06:00"),
      'type': 'Test',
    },

    {
      "title": "Final", // Originally: "Final Exam (Day & Evening)"
      "startDate": DateTime.parse("2026-04-18T00:00:00+06:00"),
      "endDate": DateTime.parse("2026-04-27T00:00:00+06:00"),
      'type': 'Test',
    },
  ];

  // 2. The Path: Collection 'course' -> Document 'CSE'
  // Based on your screenshot, the field is ON the 'CSE' document itself.
  DocumentReference docRef = FirebaseFirestore.instance
      .collection('department')
      .doc('CSE');

  try {
    // 3. Update the Field directly
    // This REPLACES the list. Perfect for a new semester reset.
    await docRef.update({'no_class': rawData});

    print("✅ Successfully updated 'academic_calendar' in /course/CSE");
  } catch (e) {
    print("❌ Error uploading: $e");
    // If the document 'CSE' doesn't exist yet, use set() instead:
    // await docRef.set({'academic_calendar': rawData}, SetOptions(merge: true));
  }
}
