import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;

class AuthData {
  DocumentReference<Map<String, dynamic>> saveTo(
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
}
