import 'package:academicpanel/controller/auth/signin_controller.dart';
import 'package:academicpanel/features/auth/widget/auth_headertext.dart';
import 'package:academicpanel/features/auth/widget/custom_button.dart';
import 'package:academicpanel/features/auth/widget/custom_textfield.dart';
import 'package:academicpanel/model/auth/signin_model.dart';

import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/network/check_connection/check_connection.dart';
import 'package:academicpanel/utility/error_widget/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SigninPageMain extends StatefulWidget {
  const SigninPageMain({super.key});

  @override
  State<SigninPageMain> createState() => _SigninPageMainState();
}

class _SigninPageMainState extends State<SigninPageMain> {
  final signinController = Get.put(SigninController());
  final checkConnection = Get.put(CheckConnection());
  final routesController = Get.put(RoutesController());

  bool? isStudent;

  String? emailErrorText;
  String? passErrorText;
  TextEditingController textContEmail = TextEditingController();
  TextEditingController textContPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 150, 10, 10),
        child: Center(
          child: Column(
            spacing: 80,
            children: [
              AuthHeadertext(
                title: 'Welcome back',
                subtitle:
                    "sign in to continue your journey in our academic community",
              ),
              Column(
                spacing: 20,
                children: [
                  CustomTextfield(
                    textController: textContEmail,

                    hintText: 'Enter your university email',
                    validateFields: () {
                      setState(() {
                        String email = textContEmail.text.trim().toLowerCase();

                        final studentPattern = RegExp(
                          r'^(\d{9})@student\.presidency\.edu\.bd$',
                        );
                        final staffPattern = RegExp(
                          r'^([a-zA-Z0-9._-]+)@pu\.edu\.bd$',
                        );

                        if (studentPattern.hasMatch(email)) {
                          // Extract prefix

                          emailErrorText = null;

                          isStudent = true;
                        } else if (staffPattern.hasMatch(email)) {
                          emailErrorText = null;

                          isStudent = false;
                        } else {
                          emailErrorText = "Invalid email format";
                        }
                      });
                    },
                    errorText: emailErrorText,
                    maxline: 1,

                    lebalText: 'Email',
                  ),
                  CustomTextfield(
                    textController: textContPass,
                    hintText: 'Enter a password',
                    errorText: passErrorText,
                    validateFields: () {
                      setState(() {
                        if (textContPass.text.trim().length < 5) {
                          passErrorText =
                              '*Password length must be grater then 8 needed';
                        } else {
                          passErrorText = null;
                        }
                      });
                    },
                    maxline: 1,
                    lebalText: 'Password',
                  ),
                ],
              ),
              Obx(() {
                return CustomButton(
                  text: 'Sign-In',

                  onPressed: () async {
                    try {
                      await checkConnection.checkConnection();

                      if (textContEmail.text.isEmpty ||
                          textContPass.text.isEmpty) {
                        errorSnackbar(
                          title: 'Sorry!!!',
                          subtitle: 'Fill up all the field',
                        );
                      } else {
                        final user = SigninModel(
                          email: textContEmail.text.trim(),
                          password: textContPass.text.trim(),

                          uid: '',
                        );
                        signinController.mainFunction(
                          user,
                          isStudent!,
                          routesController,
                        );
                      }
                    } catch (e) {
                      errorSnackbar(title: 'Sorry', e: e);
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
