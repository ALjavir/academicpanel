import 'package:academicpanel/features/auth/widget/global_widget/auth_headertext.dart';
import 'package:academicpanel/features/auth/widget/global_widget/custom_button.dart';
import 'package:academicpanel/features/auth/widget/global_widget/custom_dropdown_button.dart';
import 'package:academicpanel/features/auth/widget/global_widget/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignupPageMain extends StatefulWidget {
  const SignupPageMain({super.key});

  @override
  State<SignupPageMain> createState() => _SignupPageMainState();
}

class _SignupPageMainState extends State<SignupPageMain> {
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
        child: Center(
          child: Column(
            spacing: 60,
            children: [
              AuthHeadertext(
                title: "Create Your Account",
                subtitle:
                    "As Student or Faculty to begin your journey with our academic community.",
              ),
              Column(
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
                                firstnameErrorText = '*Name is too short.';
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
                                lastNameErrorText = '*Name is too short.';
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
                        String email = textContEmail.text.trim().toLowerCase();

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
                          String id = staffPattern.firstMatch(email)!.group(1)!;

                          emailErrorText = null;
                          textContID.text = id;
                          isStudent = false;
                        } else {
                          emailErrorText = "Invalid email format";
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
                              '*Password length must be grater then 8 needed';
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
                ],
              ),
              CustomButton(
                text: 'Create your account',
                onPressed: () async {
                  return print("object");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
