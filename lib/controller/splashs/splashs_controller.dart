import 'package:academicpanel/controller/masterController/load_allData.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:academicpanel/network/save_data/local_stroge/local_stoge.dart';
import 'package:academicpanel/utility/error_snackbar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashsController extends GetxController {
  final LocalStoge localStoge = LocalStoge();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseDatapath firebaseDatapath = FirebaseDatapath();

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final userController = Get.find<UserController>();
  final loadAlldata = Get.put(LoadAlldata());

  RxBool isLoading = true.obs;

  Future<bool> mainFunction() async {
    //final user = auth.currentUser;

    // Read secure storage in parallel
    final results = await localStoge.readDataLocal();
    final storedDept = await results[1];
    final storedRoleId = await results[0];
    final storedId = await results[2];
    // print('---$storedUid--------------$storedRole------------$storedDept');

    // Determine subcollection name once

    // Not signed in or missing local context → go to signup
    if (storedDept == null || storedId == null || storedRoleId == null) {
      localStoge.deletDataLocal();
      await auth.signOut();
      isLoading.value = false;
      // routesController.signup();
      // print('Inside null----------------------------');
      return false;
    }

    // Build the document path
    final userDocRef = firebaseDatapath.userData(
      storedDept,
      storedRoleId,
      storedId,
    ); // the uid

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

      await loadAlldata.mainLoadAllData();

      // Everything OK → go home
      isLoading.value = false;
      // routesController.home();
      return true;
    } catch (e) {
      isLoading.value = false;
      errorSnackbar(title: 'Error', e: e);
      // print('Inside $e----------------------------');
      return false;
    }
  }
}
