import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadaccount() async {
  final Map<String, Map<String, dynamic>> installment = {
    "1": {
      "amount_%": 50,
      "deadline": DateTime.parse("2026-01-18T00:00:00+06:00"),
      "fine": 500,
    },
    "2": {
      "amount_%": 70,
      "deadline": DateTime.parse("2026-03-02T00:00:00+06:00"),
      "fine": 500,
    },
    "3": {
      "amount_%": 100,
      "deadline": DateTime.parse("2026-03-20T00:00:00+06:00"),
      "fine": 500,
    },
  };

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('accounts')
      .doc('CSE')
      .collection('semester')
      .doc('Spring-26');

  try {
    // 3. Update the Field directly
    // This REPLACES the list. Perfect for a new semester reset.
    await docRef.update({'installment': installment});
    // await docRef.update({'payments': payments});
    // await docRef.update({'balance': balance});
    // await docRef.update({'per_credit': per_credit});
    // await docRef.update({'totalFine': totalFine});
    // await docRef.update({'waver_%': waverPercent});

    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
    // If the document 'CSE' doesn't exist yet, use set() instead:
    // await docRef.set({'academic_calendar': rawData}, SetOptions(merge: true));
  }
}
