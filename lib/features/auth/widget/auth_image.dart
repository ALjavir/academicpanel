import 'dart:io';

import 'package:academicpanel/controller/auth/signup_controller.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class AuthImage extends StatelessWidget {
  // We can use StatelessWidget now because the state is in the Controller!
  final SignupController signupController =
      Get.find(); // Use 'find' to get the existing instance

  AuthImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Image:',
          style: Fontstyle.defult(18, FontWeight.normal, ColorStyle.Textblue),
        ),
        SizedBox(height: 10),
        Obx(() {
          // Read directly from the controller
          File? currentImage = signupController.selectedImage.value;

          return InkWell(
            onTap: () {
              signupController.pickImage();
            },
            child: Center(
              child: Container(
                height: 200,
                width: 200,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        12,
                        0,
                        0,
                        0,
                      ), // Soft dark shadow
                      blurRadius: 6,
                      offset: Offset(6, 6), // Softness
                      spreadRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: ColorStyle.light, // Background color if no image
                  image: currentImage != null
                      ? DecorationImage(
                          image: FileImage(currentImage),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: AssetImage(ImageStyle.signUpAddImageIcon()),
                          fit: BoxFit.cover,
                        ),
                ),
                child: Icon(Icons.edit, color: ColorStyle.light),
              ),
            ),
          );
        }),
      ],
    );
  }
}
