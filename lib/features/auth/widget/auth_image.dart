import 'dart:io';

import 'package:academicpanel/controller/auth/signup_controller.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
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
          style: Fontstyle.auth(18, FontWeight.normal, ColorStyle.blue),
        ),
        SizedBox(height: 10),
        Obx(() {
          // Read directly from the controller
          File? currentImage = signupController.selectedImage.value;

          return Center(
            child: Container(
              height: 200,
              width: 200,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black45, // Background color if no image
                image: currentImage != null
                    ? DecorationImage(
                        image: FileImage(currentImage),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: IconButton(
                onPressed: () {
                  // Just call the function. The controller updates itself.
                  signupController.pickImage();
                },
                icon: Icon(
                  currentImage == null ? Icons.add_a_photo : Icons.edit,
                  color: ColorStyle.light,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
