// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:academicpanel/model/auth/signup_model.dart';
import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/utility/error_widget/error_snackbar.dart';
import 'package:academicpanel/utility/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignupController extends GetxController {
  RxBool isLoading = true.obs;
  final _secureStorage = const FlutterSecureStorage();
  final routesController = Get.put(RoutesController());
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // Timer for polling email verification status
  Timer? _timer;

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // ///////////////////////////// Main Signup Function
  Future<void> mainFunction(SignupModel signupmodel, bool isStudent) async {
    print("--- Starting Signup Process ---");

    // STEP 1 & 2: Create User (Implicitly checks if email exists via try/catch)
    UserCredential cred;
    try {
      cred = await fireAuth.createUserWithEmailAndPassword(
        email: signupmodel.email,
        password: signupmodel.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'This email is already registered.');
      } else {
        Get.snackbar('Signup Error', e.message ?? e.code);
      }
      return;
    } catch (e) {
      Get.snackbar('Signup Error', e.toString());
      return;
    }

    if (cred.user == null) return;

    // STEP 2: Send Verification Email
    try {
      await cred.user!.sendEmailVerification();
    } catch (e) {
      // If we can't send the email, we must rollback (delete user)
      await _rollbackAuth(cred.user);
      Get.snackbar('Error', 'Failed to send verification email.');
      return;
    }

    // STEP 3 & 4: Show Dialog and Wait for Verification (Polling)
    // We pass the user credentials to the dialog logic
    bool isVerified = await _showVerificationDialog(cred.user!);

    if (isVerified) {
      // STEP 5 & 6: Atomic Save (Firestore + Local)
      final saved = await saveDataAtomic(signupmodel, isStudent, cred);

      if (saved) {
        Get.snackbar("Success", "Account created successfully!");
        routesController.home();
      } else {
        // saveDataAtomic handles its own rollback internally,
        // but if it returned false, it means we failed.
        print("Save failed, user should be deleted by saveDataAtomic rollback");
      }
    } else {
      // User dismissed dialog without verifying or timed out
      await _rollbackAuth(cred.user);
      print("Email verification failed or cancelled");
    }
    isLoading.value = false;
  }

  // ////////////////////////////////////// Polling Dialog Logic
  Future<bool> _showVerificationDialog(User user) async {
    bool verified = false;

    // Start a timer to check status every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      // We must reload the user to get the latest emailVerified status
      await user.reload();
      final freshUser = fireAuth.currentUser;

      if (freshUser != null && freshUser.emailVerified) {
        verified = true;
        timer.cancel();
        if (Get.isDialogOpen ?? false) {
          Get.back(); // Close the dialog automatically
        }
      }
    });

    await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Email Verification',
                style: Fontstyle.auth(22, FontWeight.w500, ColorStyle.blue),
              ),
              Divider(height: 1, color: ColorStyle.red),
              const SizedBox(height: 10),
              Text(
                "A verification link has been sent to ${user.email} Please check your inbox or spam folder.",
                style: Fontstyle.auth(14, FontWeight.normal, ColorStyle.blue),
              ),

              const SizedBox(height: 8),

              Text(
                '*This dialog will close automatically when verified.',
                style: Fontstyle.auth(12, FontWeight.normal, ColorStyle.red),
              ),

              const SizedBox(height: 10),
              Center(child: const Loading(hight: 60)),

              Align(
                alignment: AlignmentGeometry.bottomRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _timer?.cancel();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorStyle.red,
                    padding: EdgeInsets.all(10),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                  label: Text(
                    "Cancle",
                    style: Fontstyle.auth(14, FontWeight.bold, Colors.white),
                  ),

                  icon: Icon(Icons.arrow_forward_outlined, color: Colors.white),
                  iconAlignment: IconAlignment.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    _timer?.cancel(); // Ensure timer is killed if dialog closes
    return verified;
  }

  // ////////////////////////////////////// Atomic Save Data
  Future<bool> saveDataAtomic(
    SignupModel signupmodel,
    bool isStudent,
    UserCredential cred,
  ) async {
    print("--- Saving Data Atomically ---");

    String role = isStudent ? 'students' : 'faculty';
    String roleId = isStudent ? 'student_id' : 'faculty_id';
    String department;

    // Mapping Department
    if (signupmodel.department == 'CSE') {
      department = 'DEPT_CSE';
    } else if (signupmodel.department == 'EEE') {
      department = 'DEPT_EEE';
    } else {
      Get.snackbar('Error', 'Invalid department');
      await _rollbackAuth(cred.user);
      return false;
    }

    final uid = cred.user!.uid;

    // NOTE: Removed strict "exists" check on the parent document.
    // Firestore documents that only act as folders for subcollections (Phantom Docs)
    // return exists:false, which was causing your error.
    // Since we hardcode 'department' above, we are guaranteed to write to the correct path.

    final userDocRef = fireStore
        .collection(role)
        .doc(department)
        .collection(roleId)
        .doc(uid);

    bool firestoreWritten = false;
    bool localSaved = false;

    try {
      // 1) Write Firestore
      await userDocRef.set(signupmodel.copyWith(uid: uid).toJson());
      firestoreWritten = true;

      // 2) Write Local Storage
      await _secureStorage.write(key: 'uid', value: uid);
      await _secureStorage.write(key: 'department', value: department);
      await _secureStorage.write(key: 'role', value: role);
      localSaved = true;

      return true;
    } catch (e) {
      print("Save failed. Initiating Rollback. Error: $e");

      // ROLLBACK PROCEDURE

      // 1. Delete Local Storage keys if they were written
      if (localSaved) {
        await _secureStorage.delete(key: 'uid');
        await _secureStorage.delete(key: 'department');
        await _secureStorage.delete(key: 'role');
      }

      // 2. Delete Firestore Doc if it was written
      if (firestoreWritten) {
        try {
          await userDocRef.delete();
        } catch (_) {
          print("Critical: Failed to rollback Firestore data");
        }
      }

      // 3. Delete Auth User (Always do this last in the catch block)
      await _rollbackAuth(cred.user);

      Get.snackbar('Save Error', 'Registration failed. Please try again.');
      return false;
    }
  }

  // Helper to delete user safely
  Future<void> _rollbackAuth(User? user) async {
    if (user == null) return;
    try {
      await user.delete();
      print("Auth user rolled back successfully");
    } catch (e) {
      print("Failed to delete user during rollback: $e");
    }
  }
}

// class SignupController extends GetxController {
//   final _secureStorage = const FlutterSecureStorage();
//   final routesController = Get.put(RoutesController());
//   final FirebaseAuth fireAuth = FirebaseAuth.instance;
//   final FirebaseFirestore fireStore = FirebaseFirestore.instance;

//   ///////////////////////Check if the email exist previously
//   Future<bool> emailExists(String email) async {
//     print(
//       "----------------------------------------------inside emailExists-----------------------------------------------",
//     );
//     if (fireAuth.currentUser != null) {
//       throw FirebaseAuthException(
//         code: 'user-already-signed-in',
//         message: 'Sign out current user before checking an email.',
//       );
//     }

//     UserCredential? tempCred;
//     try {
//       tempCred = await fireAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: "TempPassword123!",
//       );
//       return false; // email did NOT exist
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') return true;
//       rethrow; // or return false depending on your goals
//     } finally {
//       try {
//         await tempCred?.user?.delete();
//       } catch (_) {}
//     }
//   }

//   /////////////////////////////main function that call other functions for verification
//   Future<void> mainFunction(
//     SignupModel signupmodel,
//     bool isStudent,
//     BuildContext context,
//   ) async {
//     print(
//       "----------------------------------------------inside mainFunction-----------------------------------------------",
//     );
//     // create user in Auth
//     UserCredential cred;
//     try {
//       cred = await fireAuth.createUserWithEmailAndPassword(
//         email: signupmodel.email,
//         password: signupmodel.password,
//       );
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar('Signup Error', e.message ?? e.code);
//       return;
//     } catch (e) {
//       Get.snackbar('Signup Error', e.toString());
//       return;
//     }

//     // defensive null check (very unlikely, but safe)
//     if (cred.user == null) {
//       Get.snackbar('Signup Error', 'Failed to create user.');
//       return;
//     }

//     // send a verification email

//     final linkSend = await verificationEamilSend(cred.user!);
//     if (!linkSend) {
//       // failed to send verification email
//       try {
//         await cred.user?.delete();
//       } catch (e) {
//         errorSnackbar(title: 'Verification link', e: e);
//       }
//       return;
//     }
//     await verificationShowDialog(context, cred.user!);

//     // show the alert dialog and await its dismissal

//     // after the dialog is dismissed, check verification status
//     final verified = await emaliVerified(context, cred.user!);

//     if (verified == true) {
//       // save the data atomically (firestore, local, auth)
//       final saved = await saveDataAtomic(signupmodel, isStudent, context, cred);
//       if (saved) {
//         routesController.home();
//       }
//     } else {
//       // not verified -> delete created user to avoid orphan account
//       try {
//         await cred.user?.delete();
//       } catch (e) {
//         errorSnackbar(title: 'Evail verification faield', e: e);
//       }
//       print("Email verification failed");
//     }
//   }

//   ////////////////////////////////////////send an email with verification link to user
//   Future<bool> verificationEamilSend(User curentUser) async {
//     print(
//       "----------------------------------------------inside verificationEamilSend-----------------------------------------------",
//     );
//     try {
//       await curentUser.sendEmailVerification();
//       return true;
//     } catch (e) {
//       errorSnackbar(title: "Verification email failed to send", e: e);
//       return false;
//     }
//   }

//   //////////////////////////////////////////////email is verified
//   Future<bool> emaliVerified(BuildContext context, User curentUser) async {
//     print(
//       "----------------------------------------------inside emaliVerified-----------------------------------------------",
//     );
//     try {
//       await curentUser.reload();

//       // refresh FirebaseAuth.currentUser reference and return the flag
//       final reloaded = fireAuth.currentUser;
//       return reloaded?.emailVerified ?? false;
//     } catch (e) {
//       errorSnackbar(title: "Error", e: e);
//       return false;
//     }
//   }

//   //////////////////////////////////////Save data to Firestore, local storage, auth (atomic-ish)
//   Future<bool> saveDataAtomic(
//     SignupModel signupmodel,
//     bool isStudent,
//     BuildContext context,
//     UserCredential cred,
//   ) async {
//     print(
//       "----------------------------------------------inside saveDataAtomic-----------------------------------------------",
//     );
//     String role;
//     String department;
//     String role_id;

//     // find the path
//     if (isStudent) {
//       role = 'students';
//       role_id = 'student_id';
//       if (signupmodel.department == 'CSE') {
//         department = 'DEPT_CSE';
//       } else if (signupmodel.department == 'EEE') {
//         department = 'DEPT_EEE';
//       } else {
//         Get.snackbar('Error', 'Invalid department');
//         return false;
//       }
//     } else {
//       role = 'faculty';
//       role_id = 'faculty_id';
//       if (signupmodel.department == 'CSE') {
//         department = 'DEPT_CSE';
//       } else if (signupmodel.department == 'EEE') {
//         department = 'DEPT_EEE';
//       } else {
//         Get.snackbar('Error', 'Invalid department');
//         return false;
//       }
//     }

//     // pre-check: department doc must exist
//     final deptDocRef = fireStore.collection(role).doc(department);
//     final deptSnap = await deptDocRef.get();
//     if (!deptSnap.exists) {
//       errorSnackbar(
//         title: 'Error',
//         subtitle: 'Department not found. Contact admin.',
//       );

//       // cleanup auth if desired (you probably created user already)
//       try {
//         await cred.user?.delete();
//       } catch (_) {}
//       return false;
//     }

//     final uid = cred.user!.uid;
//     final userDocRef = fireStore
//         .collection(role)
//         .doc(department)
//         .collection(role_id)
//         .doc(uid);

//     var firestoreWritten = false;
//     var localSaved = false;
//     var authExists = true; // cred indicates auth created

//     try {
//       // 1) Write Firestore user document
//       await userDocRef.set(signupmodel.copyWith(uid: uid).toJson());
//       firestoreWritten = true;

//       // 2) Save local compact record
//       await _secureStorage.write(key: 'uid', value: uid);
//       await _secureStorage.write(key: 'department', value: department);
//       await _secureStorage.write(key: 'role', value: role);
//       localSaved = true;

//       return true;
//     } catch (e, st) {
//       // Something failed — roll back what succeeded
//       if (localSaved) {
//         try {
//           await _secureStorage.delete(key: 'uid');
//           await _secureStorage.delete(key: 'department');
//           await _secureStorage.delete(key: 'isStudent');
//         } catch (_) {}
//       }

//       if (firestoreWritten) {
//         try {
//           await userDocRef.delete();
//         } catch (_) {}
//       }

//       if (authExists) {
//         try {
//           await cred.user?.delete();
//         } catch (_) {}
//       }

//       errorSnackbar(
//         title: 'Save Error',
//         subtitle: 'Failed to save user data. Try again.',
//       );
//       print('saveDataAtomic error: $e\n$st');
//       return false;
//     }
//   }

//   ////////////////////////////////////////// show User The verification alert dialog
//   Future<void> verificationShowDialog(BuildContext context, User curentUser) {
//     return showDialog<void>(
//       barrierDismissible: false,
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: Text(
//             'Email Verification',
//             style: Fontstyle.auth(22, FontWeight.w500, ColorStyle.blue),
//           ),
//           content: Text(
//             'A verification link was sent to ${curentUser.email}. '
//             'Please check your inbox or spam folder.',
//             style: Fontstyle.auth(14, FontWeight.normal, ColorStyle.lightBlue),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 "OK",
//                 style: Fontstyle.auth(22, FontWeight.w500, ColorStyle.red),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
