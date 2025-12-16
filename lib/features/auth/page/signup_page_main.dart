import 'package:academicpanel/controller/auth/signup_controller.dart';
import 'package:academicpanel/features/auth/widget/auth_headertext.dart';
import 'package:academicpanel/features/auth/widget/auth_image.dart';
import 'package:academicpanel/features/auth/widget/custom_button.dart';
import 'package:academicpanel/features/auth/widget/custom_dropdown_button.dart';
import 'package:academicpanel/features/auth/widget/custom_textfield.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:academicpanel/network/check_connection/check_connection.dart';

import 'package:academicpanel/theme/animation/diagonal_reveal.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/utility/error_widget/error_snackBar.dart';
import 'package:academicpanel/utility/loading/loading.dart';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignupPageMain extends StatefulWidget {
  const SignupPageMain({super.key});

  @override
  State<SignupPageMain> createState() => _SignupPageMainState();
}

class _SignupPageMainState extends State<SignupPageMain> {
  final routesController = Get.put(RoutesController());
  final signupController = Get.put(SignupController());
  final checkConnection = Get.put(CheckConnection());
  String? firstnameErrorText;
  String? lastNameErrorText;
  String? emailErrorText;
  bool? isStudent;
  String? passErrorText;
  String? phoneErrorText;
  String? addErrorText;
  String? selectedDepartment;

  TextEditingController textConFirstName = TextEditingController();
  TextEditingController textConLastName = TextEditingController();
  TextEditingController textContID = TextEditingController();
  TextEditingController textContEmail = TextEditingController();
  TextEditingController textContPass = TextEditingController();
  TextEditingController textContPhone = TextEditingController();
  TextEditingController textContAddress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.light,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 80, 10, 10),
        child: DiagonalReveal(
          duration: Duration(seconds: 2),
          child: Column(
            children: [
              AuthHeadertext(
                title: "Create Your Account",
                subtitle:
                    "as Student or Faculty to begin your journey with our academic community.",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 60),
                child: Column(
                  spacing: 15,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Flexible(
                          child: CustomTextfield(
                            textController:
                                textConFirstName, // ← separate controller
                            hintText: 'Enter first name',
                            validateFields: () {
                              setState(() {
                                if (textConFirstName.text.trim().length < 2) {
                                  firstnameErrorText = '*Too short.';
                                } else {
                                  firstnameErrorText = null;
                                }
                              });
                            },
                            errorText: firstnameErrorText,
                            maxline: 1,

                            lebalText: 'First name',
                          ),
                        ),

                        Flexible(
                          child: CustomTextfield(
                            textController: textConLastName,
                            hintText: 'Enter last name',
                            validateFields: () {
                              setState(() {
                                if (textConLastName.text.trim().length < 2) {
                                  lastNameErrorText = '*Too short.';
                                } else {
                                  lastNameErrorText = null;
                                }
                              });
                            },
                            errorText: lastNameErrorText,
                            maxline: 1,

                            lebalText: 'Last name',
                          ),
                        ),
                      ],
                    ),

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
                            emailErrorText = "*Invalid email format";
                            textContID.clear();
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
                                '*Password length must be grater then 8';
                          } else {
                            passErrorText = null;
                          }
                        });
                      },
                      maxline: 1,
                      lebalText: 'Password',
                    ),
                    CustomTextfield(
                      textController: textContPhone,
                      hintText: 'Enter your phone number',
                      errorText: phoneErrorText,
                      validateFields: () {
                        setState(() {
                          if (textContPhone.text.trim().length != 11) {
                            phoneErrorText = '*Invalid phone number';
                          } else {
                            phoneErrorText = null;
                          }
                        });
                      },
                      maxline: 1,
                      lebalText: 'Phone number',
                    ),
                    CustomTextfield(
                      textController: textContAddress,
                      hintText: 'Enter your  Address',
                      errorText: addErrorText,
                      validateFields: () {
                        setState(() {
                          if (textContAddress.text.trim().length < 10) {
                            addErrorText = '*Address is too short';
                          } else {
                            addErrorText = null;
                          }
                        });
                      },
                      maxline: 2,
                      lebalText: "Address",
                    ),
                    CustomDropdownbutton(
                      initialValue: selectedDepartment,
                      onChanged: (value) {
                        //print("Selected Department: $value");
                        selectedDepartment = value;
                      },
                    ),
                    AuthImage(),
                  ],
                ),
              ),

              Obx(() {
                return signupController.isLoading.isTrue
                    ? Loading(hight: 70)
                    : Column(
                        children: [
                          CustomButton(
                            text: 'Create your account',

                            onPressed: () async {
                              await checkConnection.checkConnection();
                              try {
                                if (textConFirstName.text.isEmpty ||
                                    textConLastName.text.isEmpty ||
                                    textContEmail.text.isEmpty ||
                                    textContPass.text.isEmpty ||
                                    textContID.text.isEmpty ||
                                    textContPhone.text.isEmpty ||
                                    textContAddress.text.isEmpty ||
                                    selectedDepartment.toString().isEmpty) {
                                  errorSnackbar(
                                    title: 'Sorry!!!',
                                    subtitle:
                                        'Fill up all the field with or without image',
                                  );
                                } else if (selectedDepartment.toString() ==
                                    'invalid') {
                                  errorSnackbar(
                                    title: 'Sorry!!!',
                                    subtitle:
                                        'No department name $selectedDepartment}',
                                  );
                                } else {
                                  final user = UserModel(
                                    firstName: textConFirstName.text.trim(),
                                    lastName: textConLastName.text.trim(),
                                    email: textContEmail.text.trim(),
                                    password: textContPass.text.trim(),
                                    department: selectedDepartment!,
                                    address: textContAddress.text.trim(),
                                    phone:
                                        int.tryParse(
                                          textContPhone.text.trim(),
                                        ) ??
                                        0,
                                    uid: '',
                                    id: textContID.text.trim(),
                                  );
                                  await signupController.mainFunction(
                                    user,
                                    isStudent!,
                                    routesController,
                                    // context,
                                  );
                                }
                              } catch (e) {
                                errorSnackbar(title: 'Sorry', e: e);
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have a account?',
                                style: Fontstyle.defult(
                                  14,
                                  FontWeight.normal,
                                  ColorStyle.lightBlue,
                                ),
                              ),

                              TextButton(
                                onPressed: () {
                                  routesController.signin();
                                },
                                child: Text(
                                  "Sign-In",

                                  style: Fontstyle.defult3d(
                                    18,
                                    FontWeight.bold,
                                    ColorStyle.red,
                                    const Color.fromARGB(30, 159, 27, 25),
                                    const Offset(3, 3),
                                    3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
