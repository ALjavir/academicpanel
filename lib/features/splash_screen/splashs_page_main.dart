import 'package:academicpanel/controller/splashs/splashs_controller.dart';
import 'package:academicpanel/network/check_connection/check_connection.dart';
import 'package:academicpanel/theme/animation/animated_background_v2.dart';
import 'package:academicpanel/theme/animation/animation_background.dart';
import 'package:academicpanel/theme/animation/blurry_typewriter_text.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/utility/loading/loading.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

class SplashsPageMain extends StatefulWidget {
  const SplashsPageMain({super.key});

  @override
  State<SplashsPageMain> createState() => _SplashsPageMainState();
}

class _SplashsPageMainState extends State<SplashsPageMain> {
  final splashController = Get.put(SplashsController());
  final checkConnection = Get.put(CheckConnection());

  @override
  void initState() {
    super.initState();
    _initUserStatus();
  }

  Future<void> _initUserStatus() async {
    // await checkConnection.checkConnection();
    // await splashController.mainFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.glassWhite,
      body: Obx(() {
        final isLoading = splashController.isLoading.value;
        return Center(
          child: Column(
            spacing: 0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 1),
                child: Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    ImageStyle.logo(),
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),
                ),
              ),
              LottieBuilder.asset(
                repeat: false,
                ImageStyle.logol(),
                frameRate: FrameRate.composition,
              ),
              Expanded(flex: 0, child: SizedBox()),

              // Inside your Column or Stack
              BlurryTypewriterText(
                text: 'Presidency University',
                style: Fontstyle.splashS(32), // Your existing style
                // Customization
                duration: const Duration(
                  milliseconds: 3000,
                ), // Slower = more cinematic
                blurStrength: 0.5, // Higher = more "misty" start
              ),

              isLoading ? Loading(hight: 90) : const SizedBox(height: 10),
            ],
          ),
        );
      }),
    );
  }
}
