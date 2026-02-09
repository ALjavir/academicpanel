import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/department/department_controller.dart';
import 'package:academicpanel/controller/result/result_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/features/splash_screen/splashs_page_main.dart';
import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/network/api/firebase_initialize.dart';
import 'package:academicpanel/utility/check_connection.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  await firebaseInitialize();
  Get.put(UserController(), permanent: true);
  Get.put(CourseController(), permanent: true);
  Get.put(DepartmentController(), permanent: true);
  Get.put(ResultController(), permanent: true);
  Get.put(RoutesController(), permanent: true);
  Get.put(CheckConnection(), permanent: true);

  //Future.wait([result(), result1(), result2(), result3(), result4()]);

  //await uploadmix();

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
