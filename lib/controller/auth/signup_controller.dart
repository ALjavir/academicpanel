import 'package:academicpanel/model/auth/signup_model.dart';
import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/utility/error_widget/error_snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignupController extends GetxController {
  final routesController = Get.put(RoutesController());
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<bool> emailExists(String email) async {
    if (fireAuth.currentUser != null) {
      // There is already a signed-in user — don't run the temp-create trick.
      // Decide how you want to handle this in your app.
      throw FirebaseAuthException(
        code: 'user-already-signed-in',
        message: 'Sign out current user before checking an email.',
      );
    }

    UserCredential? tempCred;
    try {
      tempCred = await fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: "TempPassword123!",
      );
      return false; // email did NOT exist
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') return true;
      rethrow; // or return false depending on your goals
    } finally {
      try {
        await tempCred?.user?.delete();
      } catch (_) {}
    }
  }

  Future<void> mainFunction(
    SignupModel signupmodel,
    bool isStudent,
    BuildContext context,
  ) async {
    String role;
    String department;
    String role_id;

    if (isStudent == true) {
      role = 'students';
      role_id = 'student_id';
      if (signupmodel.department == 'CSE') {
        department = 'DEPT_CSE';
      } else if (signupmodel.department == 'EEE') {
        department = 'DEPT_EEE';
      } else {
        // invalid dept
        Get.snackbar('Error', 'Invalid department');
        return;
      }
    } else {
      role = 'faculty';
      role_id = 'faculty_id';
      if (signupmodel.department == 'CSE') {
        department = 'DEPT_CSE';
      } else if (signupmodel.department == 'EEE') {
        department = 'DEPT_EEE';
      } else {
        // invalid dept
        Get.snackbar('Error', 'Invalid department');
        return;
      }
    }

    UserCredential cred;
    try {
      cred = await fireAuth.createUserWithEmailAndPassword(
        email: signupmodel.email,
        password: signupmodel.password,
      );
    } on FirebaseAuthException catch (e) {
      // show error and return
      Get.snackbar('Signup Error', e.message ?? e.code);
      return;
    } catch (e) {
      Get.snackbar('Signup Error', e.toString());
      return;
    }

    // wait for email verification flow (this sends verification & shows dialog)
    final verified = await emaliVerificaton(context, cred.user!);
    if (verified == true) {
      // write once to Firestore (your original simple line)
      await fireStore
          .collection(role)
          .doc(department)
          .collection(role_id)
          .doc(cred.user!.uid)
          .set(signupmodel.copyWith(uid: fireAuth.currentUser!.uid).toJson());
      // navigate or notify success as you need
      routesController.home(); // optional: change to your route
    } else {
      // not verified -> delete created user to avoid orphan account (optional)
      try {
        await cred.user?.delete();
      } catch (_) {}
      print("Email verification failed");
    }
  }

  Future<bool> emaliVerificaton(BuildContext context, User curentUser) async {
    try {
      // send verification email
      await curentUser.sendEmailVerification();

      // show dialog and wait until user dismisses it (your existing UI)
      await verificationShowDialog(context, curentUser);

      // after dialog closes, reload user to refresh emailVerified flag
      await curentUser.reload();

      // refresh FirebaseAuth.currentUser reference and return the flag
      final reloaded = fireAuth.currentUser;
      return reloaded?.emailVerified ?? false;
    } catch (e) {
      errorSnackbar(title: "Errror", e: e);
      return false;
    }
  }

  // changed to return Future so emaliVerificaton can await it
  Future<void> verificationShowDialog(BuildContext context, User curentUser) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Email Verification',
            style: Fontstyle.auth(22, FontWeight.w500, ColorStyle.blue),
          ),
          content: Text(
            'A verification link was sent to ${curentUser.email}. '
            'Please check your inbox or spam folder.',
            style: Fontstyle.auth(14, FontWeight.normal, ColorStyle.lightBlue),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: Fontstyle.auth(22, FontWeight.w500, ColorStyle.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
