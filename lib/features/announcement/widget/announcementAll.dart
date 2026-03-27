import 'package:academicpanel/controller/page/announcement_controller.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/template/normal/announcement_template.dart';
import 'package:academicpanel/theme/template/normal/dropdownbutton_template.dart';
import 'package:academicpanel/theme/template/normal/showIcon.dart';
import 'package:academicpanel/utility/loading/loadingPageContent.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

class Announcementall extends StatefulWidget {
  final AnnouncementController announcementController;
  const Announcementall({super.key, required this.announcementController});

  @override
  State<Announcementall> createState() => _AnnouncementallState();
}

class _AnnouncementallState extends State<Announcementall> {
  final RxString title = "Leatest".obs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ThreeDContainel(
        padding: EdgeInsets.all(12),
        redious: 10,
        child: Obx(() {
          final data =
              widget.announcementController.announcementPageModel.value;
          if (widget.announcementController.isAnnouncementLoadingList == true) {
            return Center(child: LoadingPageContent());
          } else if (data.announcementModel.isEmpty) {
            return Column(
              children: [
                Row(
                  spacing: 5,
                  children: [
                    ShowIcon(
                      size: 28,
                      imageName: ImageStyle.announcementIcon(),
                    ),
                    Text(
                      "Announcement",
                      style: Fontstyle.defult(
                        22,
                        FontWeight.w600,
                        ColorStyle.Textblue,
                      ),
                    ),
                  ],
                ),
                Divider(color: ColorStyle.red),
                ClipRect(
                  child: SizedBox(
                    height: 120,
                    width: double.maxFinite,
                    child: Transform.scale(
                      scale: 2,
                      child: LottieBuilder.asset(
                        ImageStyle.upCommingClassaAimatedIcon(),
                        frameRate: FrameRate.max,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "No announcement found...",
                      style: Fontstyle.defult(
                        18,
                        FontWeight.w500,
                        ColorStyle.Textblue,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(
                      spacing: 5,
                      children: [
                        ShowIcon(
                          size: 28,
                          imageName: ImageStyle.announcementIcon(),
                        ),
                        Text(
                          title.value,
                          style: Fontstyle.defult(
                            22,
                            FontWeight.w600,
                            ColorStyle.Textblue,
                          ),
                        ),
                      ],
                    ),

                    DropdownbuttonTemplate(
                      onChanged: (value) async {
                        // print(
                        //   "the selected value/////////////////////////////////////: $value",
                        // );
                        title.value = value!;
                        await widget.announcementController
                            .fetchAnnouncementPageModel(value);
                      },
                      items: widget
                          .announcementController
                          .announcementPageModel
                          .value
                          .courseName,

                      hint: 'Course',
                    ),
                  ],
                ),
                Divider(color: ColorStyle.red),
                AnnouncementTemplate(announcement: data.announcementModel),
              ],
            );
          }
        }),
      ),
    );
  }
}
