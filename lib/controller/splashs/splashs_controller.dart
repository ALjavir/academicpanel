import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/auth/user_model.dart';
import 'package:academicpanel/utility/error_widget/error_snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashsController extends GetxController {
  final storage = const FlutterSecureStorage();
  final FirebaseAuth auth = FirebaseAuth.instance;
  // final routesController = Get.put(RoutesController());
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final userController = Get.find<UserController>();

  RxBool isLoading = true.obs;

  Future<bool> mainFunction() async {
    final user = auth.currentUser;

    // Read secure storage in parallel
    final results = await Future.wait([
      storage.read(key: 'uid'),
      storage.read(key: 'role'),
      storage.read(key: 'department'),
    ]);
    final storedDept = results[2];
    final storedUid = results[0];
    final storedRole = results[1];
    // print('---$storedUid--------------$storedRole------------$storedDept');

    // Determine subcollection name once
    final storedRoleId = storedRole == 'students' ? 'student_id' : 'faculty_id';

    // Not signed in or missing local context → go to signup
    if (storedDept == null || storedUid == null || storedRole == null) {
      await storage.delete(key: 'uid');
      await storage.delete(key: 'department');
      await storage.delete(key: 'role');
      isLoading.value = false;
      // routesController.signup();
      // print('Inside null----------------------------');
      return false;
    }

    // uid mismatch → clear and go to signup
    if (storedUid != user!.uid) {
      await _clearLocalAndSignOut();
      isLoading.value = false;
      //  print('Inside storedUid != user.uid----------------------------');
      //  routesController.signup();
      return false;
    }

    // Build the document path
    final userDocRef = fireStore
        .collection(storedRole) // e.g. 'students' or 'faculty'
        .doc(storedDept) // e.g. 'cse' / 'eee'
        .collection(storedRoleId) // e.g. 'student_id' or 'faculty_id'
        .doc(storedUid); // the uid

    try {
      final snap = await userDocRef.get(); // <- no args
      if (!snap.exists) {
        // profile doc missing → treat as not onboarded
        isLoading.value = false;
        // print('Inside snap.exists----------------------------');
        // routesController.signup();
        return false;
      }

      final data = snap.data() as Map<String, dynamic>;
      final userModel = UserModel.fromJson(data);
      userController.user.value = userModel;

      // TODO: if you want, validate fields on userModel here

      // Everything OK → go home
      isLoading.value = false;
      // routesController.home();
      return true;
    } catch (e) {
      isLoading.value = false;
      errorSnackbar(title: 'Error', e: e);
      // print('Inside $e----------------------------');
      // Optional: route to a safe page
      // routesController.signup();
      return false;
    }
  }

  Future<void> _clearLocalAndSignOut() async {
    try {
      await storage.delete(key: 'department');
      await storage.delete(key: 'uid');
      await auth.signOut();
      // print("_clearLocalAndSignOut");
    } catch (_) {}
  }
}
