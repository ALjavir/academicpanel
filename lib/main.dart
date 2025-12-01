import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/features/splash_screen/splashs_page_main.dart';
import 'package:academicpanel/network/firebase/firebase_initialize.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  await firebaseInitialize();
  Get.put(UserController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: const SplashsPageMain());
  }
}
