import 'package:academicpanel/model/Auth/signin_model.dart';
import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/network/save_data/local_stroge/local_stoge.dart';
import 'package:academicpanel/utility/error_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/state_manager.dart';

class SigninController extends GetxController {
  RxBool isLoading = false.obs;
  final localStoge = LocalStoge();

  Future<User?> mainFunction(
    SigninModel signinModel,
    bool isStudent,
    RoutesController routesController,
  ) async {
    try {
      isLoading.value = true;
      // 1) Sign in
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinModel.email.trim(),
        password: signinModel.password,
      );

      final user = cred.user;
      if (user == null) return null;

      // 2) Decide role (or fetch from server—see note below)
      isLoading.value = true;
      final id = signinModel.id;
      final roleId = isStudent ? 'student_id' : 'faculty_id';
      final department = await fetchDepartment(id, roleId);

      try {
        localStoge.writeDataLocal(department, roleId, id);
      } catch (e) {
        print(e);
        errorSnackbar(title: "Error while Data saving", subtitle: e.toString());
      }

      isLoading.value = false;
      routesController.splasS();
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          errorSnackbar(
            title: 'Error',
            subtitle: 'No user found for that email.',
          );
          break;
        case 'wrong-password':
          errorSnackbar(
            title: 'Error',
            subtitle: 'Wrong password for that user.',
          );
          break;
        case 'invalid-email':
          errorSnackbar(
            title: 'Error',
            subtitle: 'Please provide a valid email address.',
          );
          break;
        case 'user-disabled':
          errorSnackbar(
            title: 'Error',
            subtitle: 'This account has been disabled.',
          );
          break;
        case 'too-many-requests':
          errorSnackbar(
            title: 'Error',
            subtitle: 'Too many attempts. Try again later.',
          );
          break;
        case 'network-request-failed':
          errorSnackbar(
            title: 'Error',
            subtitle: 'Network error. Check your connection.',
          );
          break;
        case 'invalid-credential':
          errorSnackbar(
            title: 'Error',
            subtitle: 'Invalid credentials. Please try again.',
          );
          break;
        default:
          errorSnackbar(
            title: 'Error',
            subtitle: e.message ?? 'Authentication failed.',
          );
      }
      isLoading.value = false;
      return null;
    } catch (e) {
      errorSnackbar(title: 'Error', subtitle: e.toString());
      isLoading.value = false;
      return null;
    }
  }

  Future<String> fetchDepartment(String id, String roleId) async {
    // final role = isStudent ? 'students' : 'faculty';
    // Assuming your subcollection containing user documents is named 'student_id' or 'faculty_id'

    final firestore = FirebaseFirestore.instance;

    // 1. Get all department documents inside the main role collection (e.g., 'cse', 'eee', 'bba')
    final departmentsSnap = await firestore.collection("profile").get();

    // final departmentIds = departmentsSnap.docs.map((doc) => doc.id).toList();
    // print('---Departments Retrieved for $roleId: $departmentIds');

    for (var doc in departmentsSnap.docs) {
      final departmentName = doc.id;

      // /role/departmentName/roleId/uid
      final userDoc = await firestore
          .collection('profile')
          .doc(departmentName)
          .collection(roleId)
          .doc(id)
          .get();

      print('---Checking $roleId department: $departmentName for user: $id');
      if (userDoc.exists) {
        return departmentName;
      }
    }
    isLoading.value = false;
    return 'no department';
  }
}
