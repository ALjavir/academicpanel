import 'package:academicpanel/controller/splashs/splashs_controller.dart';
import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/utility/check_connection.dart';
import 'package:academicpanel/theme/template/animation/blurry_typewriter_text.dart';
import 'package:academicpanel/theme/template/animation/diagonal_reveal.dart';
import 'package:academicpanel/theme/template/animation/threed_logo.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
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

    _startAppSequence();
  }

  Future<void> _startAppSequence() async {
    final animationTimer = Future.delayed(const Duration(seconds: 4));

    bool isUserValid = false;

    final dataFetch = Future(() async {
      await checkConnection.checkConnection();
      isUserValid = await splashController.mainFunction();
    });

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
      body: Obx(() {
        return Center(
          child: Column(
            spacing: 0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: DiagonalReveal(
                  duration: const Duration(seconds: 3),
                  child: ThreeDLogo(
                    assetName: ImageStyle.logo(),
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),
                ),
              ),
              Expanded(flex: 0, child: SizedBox()),
              isLoading.value
                  ? CircularProgressIndicator()
                  : const SizedBox(height: 90),
              BlurryTypewriterText(
                text: 'Presidency University',
                style: Fontstyle.splashS(32),
                // Customization
                duration: const Duration(seconds: 3),
                blurStrength: 0.1,
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
