// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:academicpanel/model/auth/user_model.dart';
import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/utility/error_widget/error_snackbar.dart';
import 'package:academicpanel/utility/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SignupController extends GetxController {
  RxBool isLoading = false.obs;
  final _secureStorage = const FlutterSecureStorage();
  //final routesController = Get.put(RoutesController());
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  var selectedImage = Rxn<File>();

  //----------------set a Timer to see email verification status----------------
  Timer? _timer;
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  //--------------------------Main Signup Function------------------------------
  Future<void> mainFunction(
    UserModel signupmodel,
    bool isStudent,
    RoutesController routesController,
  ) async {
    isLoading.value =
        true; // show loading--------------------------------------

    // step 1:- To check the email exist priviously-----------------------------
    UserCredential cred;
    try {
      cred = await fireAuth.createUserWithEmailAndPassword(
        email: signupmodel.email,
        password: signupmodel.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        errorSnackbar(
          title: 'Error',
          subtitle: 'This email is already registered.',
        );
      } else {
        errorSnackbar(title: 'Signup Error', e: e.message ?? e.code);
      }
      isLoading.value = false;
      return;
    } catch (e) {
      errorSnackbar(title: 'Signup Error', e: e);
      isLoading.value = false;
      return;
    }

    if (cred.user == null) {
      isLoading.value = false;
      return;
    }

    // STEP 2:- Send Verification Email-----------------------------------------
    try {
      await cred.user!.sendEmailVerification();
    } catch (e) {
      // If we can't send the email, we must rollback (delete user)
      await _rollbackAuth(cred.user);
      errorSnackbar(
        title: 'Error',
        subtitle: 'Failed to send verification email.',
      );
      isLoading.value = false;
      return;
    }

    // STEP 3:- Show verification Dialog(and send verificatin link)-------------
    bool isVerified = await _showVerificationDialog(cred.user!);

    //user verified
    if (isVerified) {
      // STEP 4:- save the data-------------------------------------------------

      final saved = await saveDataAtomic(signupmodel, isStudent, cred);

      if (saved) {
        Get.snackbar("Success", "Account created successfully!");
        routesController.splasS();
      } else {
        print("Save failed, user should be deleted by saveDataAtomic rollback");
      }
    } else {
      // User dismissed dialog without verifying or timed out
      await _rollbackAuth(cred.user);
      print("Email verification failed or cancelled");
    }
    isLoading.value = false;
  }

  //--------------------------Show dialog---------------------------------------
  Future<bool> _showVerificationDialog(User user) async {
    bool verified = false;

    // Start a timer to check status every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      // We must reload the user to get the latest emailVerified status
      await user.reload();
      final freshUser = fireAuth.currentUser;

      //if user click 'cancel'
      if (freshUser != null && freshUser.emailVerified) {
        verified = true;
        timer.cancel();
        if (Get.isDialogOpen ?? false) {
          Get.back(); // Close the dialog automatically
        }
      }
    });

    //inside showdialog style---------------------------------------------------
    await Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
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
              RichText(
                text: TextSpan(
                  style: Fontstyle.auth(14, FontWeight.normal, ColorStyle.blue),
                  children: [
                    TextSpan(text: 'A verification link has been sent to '),
                    TextSpan(
                      text: user.email,
                      style: Fontstyle.auth(
                        14,
                        FontWeight.w600,
                        ColorStyle.blue,
                      ),
                    ),
                    TextSpan(text: '. Please check your inbox or spam folder.'),
                  ],
                ),
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

    _timer?.cancel(); //Timer killed before dialog closes
    return verified;
  }

  //-----------------------------Atomic Save Data-------------------------------
  Future<bool> saveDataAtomic(
    UserModel signupmodel,
    bool isStudent,
    UserCredential cred,
  ) async {
    //role, department, student_id set------------------------------------------
    String role = isStudent ? 'students' : 'faculty';
    String roleId = isStudent ? 'student_id' : 'faculty_id';
    String department = signupmodel.department;

    final uid = cred.user!.uid;

    try {
      // Upload image if selected
      if (selectedImage.value != null) {
        String? validUrl = await uploadImageToDrive(selectedImage.value!, uid);

        if (validUrl != null) {
          signupmodel = signupmodel.copyWith(image: validUrl);
          print("Image uploaded successfully: $validUrl");
        }

        print(selectedImage.value);
      }
    } catch (e) {
      errorSnackbar(title: "Image Upload Error", e: e);
      print(e);
      // Proceed without image
    }

    print(signupmodel.image);
    //save data in 3 places(fire-store, local, fire-auth)-----------------------
    final userDocRef = fireStore
        .collection(role)
        .doc(department)
        .collection(roleId)
        .doc(uid);

    bool firestoreWritten = false;
    bool localSaved = false;

    try {
      // 1) Write Firestore-----------------------------------------------------
      await userDocRef.set(signupmodel.copyWith(uid: uid).toJson());
      firestoreWritten = true;

      // 2) Write Local Storage-------------------------------------------------
      await _secureStorage.write(key: 'uid', value: uid);
      await _secureStorage.write(key: 'department', value: department);
      await _secureStorage.write(key: 'role', value: role);
      localSaved = true;

      return true;
    } catch (e) {
      print("Save failed. Initiating Rollback. Error: $e");

      //fail safe(if any of the place had problem while save the data)----------
      // 1. Delete Local Storage keys if they were written----------------------
      if (localSaved) {
        await _secureStorage.delete(key: 'uid');
        await _secureStorage.delete(key: 'department');
        await _secureStorage.delete(key: 'role');
      }

      // 2. Delete Firestore Doc if it was written------------------------------
      if (firestoreWritten) {
        try {
          await userDocRef.delete();
        } catch (_) {
          print("Critical: Failed to rollback Firestore data");
        }
      }

      // 3. Delete Auth User (Always do this last in the catch block)-----------
      await _rollbackAuth(cred.user);

      errorSnackbar(
        title: 'Save Error',
        subtitle: 'Registration failed. Please try again.',
      );
      return false;
    }
  }

  // Helper to delete user safely-----------------------------------------------
  Future<void> _rollbackAuth(User? user) async {
    if (user == null) return;
    try {
      await user.delete();
      print("Auth user rolled back successfully");
    } catch (e) {
      print("Failed to delete user during rollback: $e");
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      // 1. Pick the image
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      // CRITICAL FIX: Stop if user cancelled (pressed back)
      if (pickedFile == null) {
        return;
      }

      // 2. Prepare paths
      final tempDir = await getTemporaryDirectory();
      final targetPath =
          "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

      // 3. Compress
      var result = await FlutterImageCompress.compressAndGetFile(
        pickedFile.path, // Use path directly from XFile
        targetPath,
        quality: 70,
        minWidth: 800,
        minHeight: 800,
      );

      // 4. Update State (Check if result is valid)
      if (result != null) {
        selectedImage.value = File(result.path);
        print("Image selected and compressed: ${result.path}");
      } else {
        // Fallback: If compression fails for some reason, use the original
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      errorSnackbar(title: 'Image Picker Error', e: e);
    }
  }

  Future<String?> uploadImageToDrive(File imageFile, String userID) async {
    // Check this URL one last time!
    const String scriptUrl =
        "https://script.google.com/macros/s/AKfycbwtmlORdUNNGB07aclHqIRoalkS2JAxHIxsqCA3jMsky2b7OJOlKbG_u6IY3c6tQlyL/exec";

    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    String fileName = "$userID.jpg";

    try {
      var response = await http.post(
        Uri.parse(scriptUrl),
        body: jsonEncode({"image": base64Image, "filename": fileName}),
      );

      // --- CASE 1: Perfect Success (200) ---
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['url'];
      }
      // --- CASE 2: Redirect (302) - The Common Fix ---
      else if (response.statusCode == 302) {
        String? newUrl = response.headers['location'];

        if (newUrl != null) {
          print("Redirecting to: $newUrl");
          // Follow the redirect manually using GET
          var getResponse = await http.get(Uri.parse(newUrl));

          if (getResponse.statusCode == 200) {
            // Verify we got JSON, not an HTML login page
            if (getResponse.body.trim().startsWith("{")) {
              var jsonResponse = jsonDecode(getResponse.body);
              return jsonResponse['url'];
            } else {
              print(
                "Error: Got HTML instead of JSON. Check Script Permissions.",
              );
              return null;
            }
          }
        }
      }

      // --- CASE 3: Failure ---
      print("Server Error: ${response.statusCode}");
      return null;
    } catch (e) {
      print("Error uploading: $e");
      return null;
    }
  }
}
