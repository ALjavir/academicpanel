import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;

class SignupApi {
  Future<DocumentReference<Map<String, dynamic>>> saveTo(
    String department,
    String roleID,
    String id,
  ) async {
    return fireStore
        .collection('profile')
        .doc(department)
        .collection(roleID)
        .doc(id);
  }
}
