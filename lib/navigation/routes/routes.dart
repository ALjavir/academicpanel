import 'package:academicpanel/features/auth/page/signin_page_main.dart';
import 'package:academicpanel/features/auth/page/signup_page_main.dart';
import 'package:academicpanel/features/splash_screen/splashs_page_main.dart';
import 'package:academicpanel/navigation/bottom_navBar/bottom_navBar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class RoutesController {
  void splasS() {
    Get.to(
      () => SplashsPageMain(),
      transition: Transition.cupertino,
      duration: const Duration(seconds: 1),
    );
  }

  void signin() {
    Get.to(
      () => SigninPageMain(),
      transition: Transition.cupertino,
      duration: const Duration(seconds: 1),
    );
  }

  void signup() {
    Get.to(
      () => SignupPageMain(),
      transition: Transition.cupertino,
      duration: const Duration(seconds: 1),
    );
  }

  void bottomNavBar() {
    Get.offAll(() => BottomNavbar());
  }
}
