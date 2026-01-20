import 'package:academicpanel/controller/auth/signin_controller.dart';
import 'package:academicpanel/features/auth/widget/auth_headertext.dart';
import 'package:academicpanel/features/auth/widget/custom_button.dart';
import 'package:academicpanel/features/auth/widget/custom_textfield.dart';
import 'package:academicpanel/model/Auth/signin_model.dart';

import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/utility/check_connection.dart';
import 'package:academicpanel/theme/template/animation/diagonal_reveal.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/utility/error_snackbar.dart';
import 'package:academicpanel/utility/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SigninPageMain extends StatefulWidget {
  const SigninPageMain({super.key});

  @override
  State<SigninPageMain> createState() => _SigninPageMainState();
}

class _SigninPageMainState extends State<SigninPageMain> {
  final signinController = Get.put(SigninController());
  final checkConnection = Get.find<CheckConnection>();
  final routesController = Get.find<RoutesController>();

  bool? isStudent;
  bool passwordVisible = true;

  String? emailErrorText;
  String? passErrorText;
  TextEditingController textContEmail = TextEditingController();
  TextEditingController textContPass = TextEditingController();
  TextEditingController textContID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.light,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 150, 10, 10),
        child: DiagonalReveal(
          duration: Duration(seconds: 2),
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
                          String email = textContEmail.text
                              .trim()
                              .toLowerCase();

                          final studentPattern = RegExp(
                            r'^(\d{9})@student\.presidency\.edu\.bd$',
                          );
                          final staffPattern = RegExp(
                            r'^([a-zA-Z0-9._-]+)@pu\.edu\.bd$',
                          );

                          if (studentPattern.hasMatch(email)) {
                            // Extract prefix
                            String id = studentPattern
                                .firstMatch(email)!
                                .group(1)!;

                            emailErrorText = null;
                            textContID.text = id;
                            isStudent = true;
                          } else if (staffPattern.hasMatch(email)) {
                            String id = staffPattern
                                .firstMatch(email)!
                                .group(1)!;
                            emailErrorText = null;
                            textContID.text = id;
                            isStudent = false;
                          } else {
                            emailErrorText = "Invalid email format";
                          }
                        });
                      },
                      errorText: emailErrorText,
                      maxline: 1,

                      lebalText: 'Email',
                      obscureText: false,
                    ),
                    CustomTextfield(
                      obscureText: passwordVisible,
                      suffixIconFun: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
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
                  return signinController.isLoading.isTrue
                      ? Loading(hight: 70)
                      : CustomButton(
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
                                  id: textContID.text.trim(),
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
      ),
    );
  }
}
