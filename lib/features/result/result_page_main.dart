import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/features/result/widget/resultTopHeader/resultTopHeader_main.dart';
import 'package:academicpanel/features/result/widget/result_currentSem.dart';
import 'package:academicpanel/navigation/appbar/custom_appbar.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/dateTime_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/template/animation/diagonal_reveal.dart';
import 'package:academicpanel/utility/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ResultPageMain extends StatefulWidget {
  const ResultPageMain({super.key});

  @override
  State<ResultPageMain> createState() => _ResultPageMainState();
}

class _ResultPageMainState extends State<ResultPageMain> {
  final resultPageController = Get.put(ResultPageController());
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.light,
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(),
      body: DiagonalReveal(
        duration: Duration(milliseconds: 300),
        child: Obx(() {
          if (resultPageController.isLoading.value) {
            return const Center(child: Loading(hight: 100));
          } else {
            return SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  ResulttopheaderMain(
                    resultPageController: resultPageController,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    DatetimeStyle.getSemester(),
                    style: Fontstyle.defult(
                      22,
                      FontWeight.w600,
                      ColorStyle.Textblue,
                    ),
                  ),
                  ResultCurrentsem(
                    resultPageController: resultPageController,
                    userController: userController,
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
