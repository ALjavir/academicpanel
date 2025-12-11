import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/features/auth/page/signup_page_main.dart';
import 'package:academicpanel/features/home/page/home_page_main.dart';
import 'package:academicpanel/features/splash_screen/splashs_page_main.dart';
import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/network/firebase/firebase_initialize.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

Future<void> main() async {
  await firebaseInitialize();
  Get.put(UserController(), permanent: true);
  Get.put(RoutesController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // Initialize RoutesController if needed, e.g. in main() or here:
  // Get.put(RoutesController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: ColorStyle.light,
      debugShowCheckedModeBanner: false,

      home: const SplashsPageMain(),
      // getPages: [
      //   GetPage(
      //     name: '/signup',
      //     page: () => const SignupPageMain(),
      //     // Force the transition here. It's much harder for Flutter to ignore this.
      //     transition: Transition.zoom,
      //     transitionDuration: const Duration(
      //       seconds: 1,
      //     ), // 1s is enough to see it
      //   ),
      //   GetPage(
      //     name: '/home',
      //     page: () => const HomePageMain(),
      //     transition: Transition.fadeIn,
      //   ),
      // ],
    );
  }
}
