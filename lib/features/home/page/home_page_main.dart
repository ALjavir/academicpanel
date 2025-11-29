import 'package:academicpanel/features/auth/widget/custom_button.dart';
import 'package:academicpanel/navigation/appbar/custom_appbar.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/utility/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class HomePageMain extends StatefulWidget {
  const HomePageMain({super.key});

  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.light,
      appBar: CustomAppbar(),

      body: IconButton(
        onPressed: () {
          Get.dialog(
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Email Verification',
                      style: Fontstyle.auth(
                        22,
                        FontWeight.w500,
                        ColorStyle.blue,
                      ),
                    ),
                    Divider(height: 1, color: ColorStyle.red),
                    const SizedBox(height: 10),
                    Text(
                      "A verification link has been sent to 222208028@student.presidency.edu.bd. Please check your inbox or spam folder.",
                      style: Fontstyle.auth(
                        14,
                        FontWeight.normal,
                        ColorStyle.blue,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '*This dialog will close automatically when verified.',
                      style: Fontstyle.auth(
                        12,
                        FontWeight.normal,
                        ColorStyle.red,
                      ),
                    ),

                    const SizedBox(height: 10),
                    Center(child: const Loading(hight: 60)),

                    Align(
                      alignment: AlignmentGeometry.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: ColorStyle.red,
                          padding: EdgeInsets.all(10),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(width: 1, color: Colors.white),
                          ),
                        ),
                        label: Text(
                          "Cancle",
                          style: Fontstyle.auth(
                            14,
                            FontWeight.bold,
                            Colors.white,
                          ),
                        ),

                        icon: Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        ),
                        iconAlignment: IconAlignment.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

          //   Get.defaultDialog(
          //     title: 'Email Verification',
          //     titleStyle: Fontstyle.auth(22, FontWeight.w500, ColorStyle.blue),

          //     content: Column(
          //       spacing: 10,
          //       children: [
          //         Text(
          //           "A verification link has been sent to 222208028@student.presidency.edu.bd. Please check your inbox or spam folder.",
          //           style: Fontstyle.auth(14, FontWeight.normal, ColorStyle.blue),
          //         ),

          //         Text(
          //           '*This dialog will close automatically when verified.',

          //           style: Fontstyle.auth(12, FontWeight.normal, ColorStyle.red),
          //         ),

          //         const Loading(hight: 60), // Visual cue that we are waiting
          //       ],
          //     ),
          //     barrierDismissible: false, // User cannot click outside to close
          //     actions: [TextButton.icon(onPressed: () {}, label: Text("Cancel"))],
          //   );
        },
        icon: Text("data"),
      ),
    );
  }
}
