import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

void errorSnackbar({required String title, String? subtitle, Object? e}) {
  // Determine the content text
  final contentText = (subtitle == null || subtitle.isEmpty)
      ? (e?.toString() ?? 'Unknown error')
      : subtitle;

  Get.snackbar(
    title, // Title uses the GetX built-in title area
    contentText, // Message uses the GetX built-in message area
    duration: const Duration(seconds: 4),

    barBlur: 10, // <— THIS blurs the snackbar background
    // backgroundColor: Colors.black26,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,

    messageText: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              Image.asset(
                ImageStyle.errorIcon(),
                scale: 14,
                color: ColorStyle.red,
              ),
              Text(
                title,
                style: Fontstyle.errorSnackBar(
                  22,
                  ColorStyle.red,
                  FontWeight.bold,
                ),
              ),
            ],
          ),

          Text(
            contentText,
            style: Fontstyle.errorSnackBar(
              22,
              ColorStyle.Textblue,
              FontWeight.normal,
            ),
          ),
        ],
      ),
    ),
    titleText: const SizedBox.shrink(),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  );
}
