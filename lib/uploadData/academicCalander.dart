import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadacademi() async {
  // 1. The Data List (Clean List of Objects)
  final List<Map<String, dynamic>> rawData = [
    {
      "title": "Spring 2026 Trimester Start",
      "date": "07 Jan",
      "day": "Wednesday",
      "type": "start",
    },
    {
      "title": "Advising/Registration (Day & Evening)",
      "date": "08-12 Jan",
      "day": "Thu-Mon",
      "type": "reg",
    },
    {
      "title": "Advising/Registration (Weekend Friday)",
      "date": "09-16 Jan",
      "day": "Fri-Fri",
      "type": "reg",
    },
    {
      "title": "Classes Start (Weekend Friday)",
      "date": "09 Jan",
      "day": "Friday",
      "type": "start",
    },
    {
      "title": "Classes Start (Weekend Sat & Day/Evening)",
      "date": "10 Jan",
      "day": "Saturday",
      "type": "start",
    },
    {
      "title": "Holiday: Shab-e-Meraj",
      "date": "17 Jan",
      "day": "Saturday",
      "type": "holiday",
    },
    {
      "title": "Late Registration Starts",
      "date": "19 Jan",
      "day": "Monday",
      "type": "deadline",
    },
    {
      "title": "Holiday: Shab-e-Barat",
      "date": "04 Feb",
      "day": "Wednesday",
      "type": "holiday",
    },
    {
      "title": "1st Installment Payment (50%)",
      "date": "15 Feb",
      "day": "Sunday",
      "type": "payment",
    },
    {
      "title": "Start of Holy Ramadan",
      "date": "18 Feb",
      "day": "Wednesday",
      "type": "holiday",
    },
    {
      "title": "Holiday: Intl Mother Language Day",
      "date": "21 Feb",
      "day": "Saturday",
      "type": "holiday",
    },
    {
      "title": "Midterm Exam Period",
      "date": "27 Feb - 08 Mar",
      "day": "Fri-Sun",
      "type": "exam",
    },
    {
      "title": "2nd Installment Payment (30%)",
      "date": "13 Mar",
      "day": "Friday",
      "type": "payment",
    },
    {
      "title": "Holiday: Shab-e-Qadar",
      "date": "17 Mar",
      "day": "Tuesday",
      "type": "holiday",
    },
    {
      "title": "Holiday: Jummatul-Bida & Eid-ul-Fitr",
      "date": "18-25 Mar",
      "day": "Wed-Wed",
      "type": "holiday",
    },
    {
      "title": "Holiday: Independence Day",
      "date": "26 Mar",
      "day": "Thursday",
      "type": "holiday",
    },
    {
      "title": "3rd Installment Payment (Remaining)",
      "date": "08 Apr",
      "day": "Wednesday",
      "type": "payment",
    },
    {
      "title": "Final Exam (Weekend)",
      "date": "10-24 Apr",
      "day": "Fri-Fri",
      "type": "exam",
    },
    {
      "title": "Holiday: Bangla New Year",
      "date": "14 Apr",
      "day": "Tuesday",
      "type": "holiday",
    },
    {
      "title": "Final Exam (Day & Evening)",
      "date": "18-27 Apr",
      "day": "Sat-Mon",
      "type": "exam",
    },
    {
      "title": "Holiday: May Day & Buddha Purnima",
      "date": "01 May",
      "day": "Friday",
      "type": "holiday",
    },
    {
      "title": "Semester Break",
      "date": "02-03 May",
      "day": "Sat-Sun",
      "type": "holiday",
    },
    {
      "title": "Summer 2026 Trimester Start",
      "date": "04 May",
      "day": "Monday",
      "type": "start",
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
    await docRef.update({'academic_calendar': rawData});

    print("✅ Successfully updated 'academic_calendar' in /course/CSE");
  } catch (e) {
    print("❌ Error uploading: $e");
    // If the document 'CSE' doesn't exist yet, use set() instead:
    // await docRef.set({'academic_calendar': rawData}, SetOptions(merge: true));
  }
}
