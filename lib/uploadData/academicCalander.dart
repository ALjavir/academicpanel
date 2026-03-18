import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadacademi() async {
  // 1. The Data List (Clean List of Objects)
  List<Map<String, dynamic>> academicCalendar = [
    {
      "title": "Spring 2026 Trimester Start",
      "type": "start",
      "startDate": DateTime(2026, 1, 7),
      "endDate": DateTime(2026, 1, 7),
    },
    {
      "title": "Advising/Registration (Day & Evening)",
      "type": "reg",
      "startDate": DateTime(2026, 1, 8),
      "endDate": DateTime(2026, 1, 12),
    },
    {
      "title": "Advising/Registration (Weekend Friday)",
      "type": "reg",
      "startDate": DateTime(2026, 1, 9),
      "endDate": DateTime(2026, 1, 16),
    },
    {
      "title": "Classes Start (Weekend Friday)",
      "type": "start",
      "startDate": DateTime(2026, 1, 9),
      "endDate": DateTime(2026, 1, 9),
    },
    {
      "title": "Classes Start (Weekend Sat & Day/Evening)",
      "type": "start",
      "startDate": DateTime(2026, 1, 10),
      "endDate": DateTime(2026, 1, 10),
    },
    {
      "title": "Holiday: Shab-e-Meraj",
      "type": "holiday",
      "startDate": DateTime(2026, 1, 17),
      "endDate": DateTime(2026, 1, 17),
    },
    {
      "title": "Late Registration Starts",
      "type": "deadline",
      "startDate": DateTime(2026, 1, 19),
      "endDate": DateTime(2026, 1, 19),
    },
    {
      "title": "Holiday: Shab-e-Barat",
      "type": "holiday",
      "startDate": DateTime(2026, 2, 4),
      "endDate": DateTime(2026, 2, 4),
    },
    {
      "title": "1st Installment Payment (50%)",
      "type": "payment",
      "startDate": DateTime(2026, 2, 15),
      "endDate": DateTime(2026, 2, 15),
    },
    {
      "title": "Start of Holy Ramadan",
      "type": "holiday",
      "startDate": DateTime(2026, 2, 18),
      "endDate": DateTime(2026, 2, 18),
    },
    {
      "title": "Holiday: Intl Mother Language Day",
      "type": "holiday",
      "startDate": DateTime(2026, 2, 21),
      "endDate": DateTime(2026, 2, 21),
    },
    {
      "title": "Midterm Exam Period",
      "type": "exam",
      "startDate": DateTime(2026, 2, 27),
      "endDate": DateTime(2026, 3, 8),
    },
    {
      "title": "2nd Installment Payment (30%)",
      "type": "payment",
      "startDate": DateTime(2026, 3, 13),
      "endDate": DateTime(2026, 3, 13),
    },
    {
      "title": "Holiday: Shab-e-Qadar",
      "type": "holiday",
      "startDate": DateTime(2026, 3, 17),
      "endDate": DateTime(2026, 3, 17),
    },
    {
      "title": "Holiday: Jummatul-Bida & Eid-ul-Fitr",
      "type": "holiday",
      "startDate": DateTime(2026, 3, 18),
      "endDate": DateTime(2026, 3, 25),
    },
    {
      "title": "Holiday: Independence Day",
      "type": "holiday",
      "startDate": DateTime(2026, 3, 26),
      "endDate": DateTime(2026, 3, 26),
    },
    {
      "title": "3rd Installment Payment (Remaining)",
      "type": "payment",
      "startDate": DateTime(2026, 4, 8),
      "endDate": DateTime(2026, 4, 8),
    },

    {
      "title": "Holiday: Bangla New Year",
      "type": "holiday",
      "startDate": DateTime(2026, 4, 14),
      "endDate": DateTime(2026, 4, 14),
    },
    {
      "title": "Final Exam (Day & Evening)",
      "type": "exam",
      "startDate": DateTime(2026, 4, 18),
      "endDate": DateTime(2026, 4, 27),
    },
    {
      "title": "Holiday: May Day & Buddha Purnima",
      "type": "holiday",
      "startDate": DateTime(2026, 5, 1),
      "endDate": DateTime(2026, 5, 1),
    },
    {
      "title": "Semester Break",
      "type": "holiday",
      "startDate": DateTime(2026, 5, 2),
      "endDate": DateTime(2026, 5, 3),
    },
    {
      "title": "Summer 2026 Trimester Start",
      "type": "start",
      "startDate": DateTime(2026, 5, 4),
      "endDate": DateTime(2026, 5, 4),
    },
  ];

  List<Map<String, dynamic>> announcements = [
    {
      "message":
          "Applications are open for Summer 2026 internships. Submit your CV by April 5",
      "createdAt": DateTime(2026, 1, 3, 12, 00, 24),
    },
    {
      "message":
          "Intra-department programming contest will be held on March 25. Register now",
      "createdAt": DateTime(2026, 1, 5, 10, 30, 00),
    },
    {
      "message":
          "Midterm exams will begin from April 10. Check the portal for details",
      "createdAt": DateTime(2026, 1, 10, 9, 15, 00),
    },
    {
      "message": "AI & Machine Learning workshop scheduled on March 28",
      "createdAt": DateTime(2026, 1, 12, 14, 00, 00),
    },
    {
      "message": "All labs will remain closed on March 20 due to maintenance",
      "createdAt": DateTime(2026, 1, 15, 11, 45, 00),
    },
    {
      "message": "Final year students must submit thesis proposals by April 1",
      "createdAt": DateTime(2026, 1, 18, 16, 20, 00),
    },
  ];
  // 2. The Path: Collection 'course' -> Document 'CSE'
  // Based on your screenshot, the field is ON the 'CSE' document itself.
  DocumentReference docRef = FirebaseFirestore.instance
      .collection('department')
      .doc('CSE')
      .collection("semester")
      .doc("Spring-26");

  try {
    // 3. Update the Field directly
    // This REPLACES the list. Perfect for a new semester reset.
    await docRef.update({'announcements': announcements});

    print("✅ Successfully updated 'academic_calendar' in /course/CSE");
  } catch (e) {
    print("❌ Error uploading: $e");
    // If the document 'CSE' doesn't exist yet, use set() instead:
    // await docRef.set({'academic_calendar': rawData}, SetOptions(merge: true));
  }
}
