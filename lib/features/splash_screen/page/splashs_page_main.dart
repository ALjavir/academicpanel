import 'package:academicpanel/controller/splashs/splashs_controller.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/utility/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SplashsPageMain extends StatefulWidget {
  const SplashsPageMain({super.key});

  @override
  State<SplashsPageMain> createState() => _SplashsPageMainState();
}

class _SplashsPageMainState extends State<SplashsPageMain> {
  final splashController = Get.put(SplashsController());

  @override
  void initState() {
    super.initState();
    _initUserStatus();
  }

  Future<void> _initUserStatus() async {
    await splashController.mainFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.light,
      body: Obx(() {
        final isLoading = splashController.isLoading.value;
        return Center(
          child: Column(
            spacing: 0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  ImageStyle.logo(),
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
              ),
              Expanded(flex: 0, child: SizedBox()),
              Text('Presidency University', style: Fontstyle.splashS(32)),
              isLoading ? Loading(hight: 90) : const SizedBox(height: 10),
            ],
          ),
        );
      }),
    );
  }
}
