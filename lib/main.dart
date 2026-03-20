import 'package:academicpanel/controller/account/account_controller.dart';
import 'package:academicpanel/controller/auth/signin_controller.dart';
import 'package:academicpanel/controller/auth/signup_controller.dart';
import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/department/department_controller.dart';
import 'package:academicpanel/controller/result/result_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/features/splash_screen/splashs_page_main.dart';
import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/network/api/firebase_initialize.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:academicpanel/utility/check_connection.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  await firebaseInitialize();
  Get.lazyPut(() => FirebaseDatapath(), fenix: true);
  Get.lazyPut(() => UserController(), fenix: true);
  Get.lazyPut(() => SignupController(), fenix: true);
  Get.lazyPut(() => SigninController(), fenix: true);
  Get.lazyPut(() => AccountController(), fenix: true);
  Get.lazyPut(() => CourseController(), fenix: true);
  Get.lazyPut(() => DepartmentController(), fenix: true);
  Get.lazyPut(() => ResultController(), fenix: true);
  Get.lazyPut(() => RoutesController(), fenix: true);
  Get.put(CheckConnection(), permanent: true);

  //Future.wait([uploadmix1(), uploadmix2(), uploadmix3(), uploadmix4()]);
  // await uploadacademi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      home: const SplashsPageMain(),
    );
  }
}
