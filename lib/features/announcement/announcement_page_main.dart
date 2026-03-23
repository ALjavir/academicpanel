import 'package:academicpanel/controller/page/announcement_controller.dart';
import 'package:academicpanel/features/announcement/widget/announcementTopHeader.dart';
import 'package:academicpanel/navigation/appbar/custom_appbar.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/template/animation/diagonal_reveal.dart';
import 'package:academicpanel/utility/loading/loadingFullPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AnnouncementPageMain extends StatefulWidget {
  const AnnouncementPageMain({super.key});

  @override
  State<AnnouncementPageMain> createState() => _AnnouncementPageMainState();
}

class _AnnouncementPageMainState extends State<AnnouncementPageMain> {
  final announcementController = Get.put(AnnouncementController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.light,
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(),
      body: Obx(() {
        if (announcementController.isAnnouncementLoading.value) {
          return const SingleChildScrollView(child: LoadingFullPage());
        } else {
          return SingleChildScrollView(
            child: DiagonalReveal(
              child: Column(
                spacing: 10,
                children: [
                  Announcementtopheader(
                    announcementPageModel:
                        announcementController.announcementPageModel.value,
                  ),
                  // ResulttopheaderMain(
                  //   resultPageController: resultPageController,
                  // ),
                  // const SizedBox(height: 10),
                  // Text(
                  //   DatetimeStyle.getSemester(),
                  //   style: Fontstyle.defult(
                  //     22,
                  //     FontWeight.w600,
                  //     ColorStyle.Textblue,
                  //   ),
                  // ),
                  // ResultCurrentsem(
                  //   resultPageController: resultPageController,
                  //   userController: userController,
                  // ),
                  // ResultPrevsem(resultPageController: resultPageController),
                  SizedBox(height: 100),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
