import 'package:academicpanel/features/auth/page/signin_page/signin_page_main.dart';
import 'package:academicpanel/features/auth/page/signup_page_main.dart';
import 'package:academicpanel/features/home/page/home_page_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class RoutesController {
  void signin() {
    Get.to(() => SigninPageMain());
  }

  void signup() {
    Get.to(() => SignupPageMain());
  }

  void home() {
    Get.to(() => HomePageMain());
  }
}
