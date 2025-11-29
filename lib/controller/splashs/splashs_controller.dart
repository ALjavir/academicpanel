import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashsController extends GetxController {
  final storage = const FlutterSecureStorage();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final routesController = Get.put(RoutesController());

  RxBool isLoading = true.obs;

  Future<void> mainFunction() async {
    // short splash delay (optional)
    //await Future.delayed(const Duration(milliseconds: 450));

    final user = auth.currentUser;

    // read department and uid from secure storage
    final storedDept = await storage.read(key: 'department');
    final storedUid = await storage.read(key: 'uid');
    final storedrole = await storage.read(key: 'role');

    // if no auth user -> go to signup
    if (user == null ||
        storedDept == null ||
        storedUid == null ||
        storedrole == null) {
      isLoading.value = false;
      routesController.signup();
      return;
    }

    // uid mismatch -> clear and go to signup
    if (storedUid != user.uid) {
      await _clearLocalAndSignOut();
      isLoading.value = false;
      routesController.signup();
      return;
    }

    routesController.home();
    // everything ok -> go to home
  }

  Future<void> _clearLocalAndSignOut() async {
    try {
      await storage.delete(key: 'department');
      await storage.delete(key: 'uid');
      await auth.signOut();
      print("_clearLocalAndSignOut");
    } catch (_) {}
  }
}
