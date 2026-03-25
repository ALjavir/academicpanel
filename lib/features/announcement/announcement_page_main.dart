import 'package:academicpanel/controller/page/announcement_controller.dart';
import 'package:academicpanel/features/announcement/widget/announcementAll.dart';
import 'package:academicpanel/features/announcement/widget/announcementTopHeader.dart';
import 'package:academicpanel/navigation/appbar/custom_appbar.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/diagonal_reveal.dart';
import 'package:academicpanel/utility/loading/loadingFullPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
        if (announcementController.isAnnouncementLoadingFull.value) {
          return const SingleChildScrollView(child: LoadingFullPage());
        } else {
          return Stack(
            alignment: AlignmentGeometry.bottomRight,
            children: [
              SingleChildScrollView(
                child: DiagonalReveal(
                  child: Column(
                    spacing: 10,
                    children: [
                      Announcementtopheader(
                        announcementPageTopHeader:
                            announcementController.announcementPageTopHeader,
                      ),
                      Announcementall(
                        announcementController: announcementController,
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 100,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () async {
                    final url = announcementController
                        .announcementPageModel
                        .value
                        .announcementModel[0]
                        .whatsApp
                        .trim();
                    final uri = Uri.tryParse(url);

                    if (uri == null) {
                      debugPrint('Invalid URL');
                      return;
                    }
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      debugPrint('Cannot launch $url');
                    }
                  },
                  elevation: 1,

                  //mini: true,
                  shape: CircleBorder(),

                  child: ClipOval(
                    child: Image.asset(
                      ImageStyle.whatsApp(),
                      fit: BoxFit.cover, // fill completely
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
