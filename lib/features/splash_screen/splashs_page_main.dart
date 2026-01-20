import 'package:academicpanel/controller/splashs/splashs_controller.dart';
import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/utility/check_connection.dart';
import 'package:academicpanel/theme/template/animation/blurry_typewriter_text.dart';
import 'package:academicpanel/theme/template/animation/diagonal_reveal.dart';
import 'package:academicpanel/theme/template/animation/threed_logo.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/utility/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashsPageMain extends StatefulWidget {
  const SplashsPageMain({super.key});

  @override
  State<SplashsPageMain> createState() => _SplashsPageMainState();
}

class _SplashsPageMainState extends State<SplashsPageMain> {
  final splashController = Get.put(SplashsController());
  final checkConnection = Get.put(CheckConnection());
  final routesController = Get.find<RoutesController>();

  RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    // Start the sequence as soon as the app launches
    _startAppSequence();
  }

  Future<void> _startAppSequence() async {
    // 1. Start Animation Timer (Minimum 3 seconds)
    final animationTimer = Future.delayed(const Duration(seconds: 3));

    // 2. Start Data Check (Returns the result, doesn't navigate yet)
    // We use a separate variable to store the result of the future
    bool isUserValid = false;

    final dataFetch = Future(() async {
      await checkConnection.checkConnection();
      // Store the result (true/false) in our variable
      isUserValid = await splashController.mainFunction();
    });

    // 3. Wait for BOTH to finish
    // This guarantees at least 3 seconds have passed
    await Future.wait([animationTimer, dataFetch]);
    isLoading = splashController.isLoading;
    if (isUserValid) {
      routesController.bottomNavBar();
      //routesController.home();
    } else {
      routesController.signup();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.light,
      // backgroundColor: Colors.transparent,
      body: Obx(() {
        //  final isLoading = isLoading.value;
        return Center(
          child: Column(
            spacing: 0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: DiagonalReveal(
                  // <--- WRAP IT HERE
                  duration: const Duration(seconds: 3), // Adjust speed
                  child: ThreeDLogo(
                    assetName: ImageStyle.logo(),
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),
                ),
              ),

              Expanded(flex: 0, child: SizedBox()),
              isLoading.value ? Loading(hight: 90) : const SizedBox(height: 90),

              // Inside your Column or Stack
              BlurryTypewriterText(
                text: 'Presidency University',
                style: Fontstyle.splashS(32), // Your existing style
                // Customization
                duration: const Duration(seconds: 3), // Slower = more cinematic
                blurStrength: 0.1, // Higher = more "misty" start
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
