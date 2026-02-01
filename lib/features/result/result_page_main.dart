import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/features/result/widget/resultTopHeader/resultTopHeader_main.dart';
import 'package:academicpanel/features/result/widget/result_currentSem.dart';
import 'package:academicpanel/navigation/appbar/custom_appbar.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ResultPageMain extends StatefulWidget {
  const ResultPageMain({super.key});

  @override
  State<ResultPageMain> createState() => _ResultPageMainState();
}

class _ResultPageMainState extends State<ResultPageMain> {
  final resultPageController = Get.put(ResultPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.light,
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ResulttopheaderMain(resultPageController: resultPageController),
            ResultCurrentsem(resultPageController: resultPageController),
          ],
        ),
      ),
    );
  }
}
