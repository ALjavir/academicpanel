import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> uploadaccount() async {
//   final Map<String, Map<String, dynamic>> installment = {
//     "1": {
//       "amount_%": 50,
//       "deadline": DateTime.parse("2026-01-18T00:00:00+06:00"),
//       "fine": 500,
//     },
//     "2": {
//       "amount_%": 70,
//       "deadline": DateTime.parse("2026-03-02T00:00:00+06:00"),
//       "fine": 500,
//     },
//     "3": {
//       "amount_%": 100,
//       "deadline": DateTime.parse("2026-03-20T00:00:00+06:00"),
//       "fine": 500,
//     },
//   };

//   ///accounts/CSE/student_id/222208038/semester/Spring-26

//   DocumentReference docRef = FirebaseFirestore.instance
//       .collection('accounts')
//       .doc('CSE');

//   try {
//     // 3. Update the Field directly
//     // This REPLACES the list. Perfect for a new semester reset.
//     await docRef.update({'installment': installment});
//     // await docRef.update({'payments': payments});
//     // await docRef.update({'balance': balance});
//     // await docRef.update({'per_credit': per_credit});
//     // await docRef.update({'totalFine': totalFine});
//     // await docRef.update({'waver_%': waverPercent});

//     print("✅ Successfully updated '$docRef");
//   } catch (e) {
//     print("❌ Error uploading: $e");
//     // If the document 'CSE' doesn't exist yet, use set() instead:
//     // await docRef.set({'academic_calendar': rawData}, SetOptions(merge: true));
//   }
// }

Future<void> uploadaccount() async {
  final Map<String, Map<String, dynamic>> acStatement = {
    'FEE014': {
      'amount': 4000,
      'credit': 0,
      'name': 'Semester Fee w.e.f 182',
      'created_at': DateTime(2026, 1, 1),
    },

    'BNG101': {
      'amount': 7500,
      'credit': 3,
      'name': 'Bangla Language and Literature',
      'created_at': DateTime(2026, 1, 1),
    },

    'CHE101': {
      'amount': 7500,
      'credit': 3,
      'name': 'General Chemistry',
      'created_at': DateTime(2026, 1, 2),
    },

    'CHE102': {
      'amount': 2500,
      'credit': 1,
      'name': 'General Chemistry Laboratory',
      'created_at': DateTime(2026, 1, 3),
    },

    'CSE101': {
      'amount': 7500,
      'credit': 3,
      'name': 'Fundamental of Computer Science',
      'created_at': DateTime(2026, 1, 1),
    },

    'FEE221': {
      'amount': 500,
      'credit': 0,
      'name':
          'Computer Lab fee (Per Semester for All Program), For Student who will get admitted from Semester-2, 2022',
      'created_at': DateTime(2026, 1, 1),
    },

    'FEE226': {
      'amount': 500,
      'credit': 3,
      'name':
          'Library Fee (Per Semester for All Program), For Student who will get admitted from Semester-2, 2022',
      'created_at': DateTime(2026, 1, 1),
    },
  };
  final List<Map<String, dynamic>> payments = [
    {
      'amount': 9000,
      'date': DateTime(2026, 1, 1),
      'from': 1777777,
      'method': 'Bkash',
      'status': 'verified',
      'transaction_id': 'TRX23...........',
    },
  ];

  final int balance = -200;
  final int perCredit = 2500;
  final int totalFine = 0;
  final int waiverPercent = 50;

  ///accounts/CSE/student_id/222208038/semester/Spring-26

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('accounts')
      .doc('CSE')
      .collection('student_id')
      .doc('222208038')
      .collection('semester')
      .doc('Spring-26');

  try {
    await docRef.update({'ac_statement': acStatement});
    await docRef.update({'payments': payments});
    await docRef.update({'balance': balance});
    await docRef.update({'per_credit': perCredit});
    await docRef.update({'totalFine': totalFine});
    await docRef.update({'waver_%': waiverPercent});

    print("✅ Successfully updated '$docRef");
  } catch (e) {
    print("❌ Error uploading: $e");
    // If the document 'CSE' doesn't exist yet, use set() instead:
    // await docRef.set({'academic_calendar': rawData}, SetOptions(merge: true));
  }
}
