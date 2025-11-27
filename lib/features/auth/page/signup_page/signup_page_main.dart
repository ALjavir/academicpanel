import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';

class SignupPageMain extends StatefulWidget {
  const SignupPageMain({super.key});

  @override
  State<SignupPageMain> createState() => _SignupPageMainState();
}

class _SignupPageMainState extends State<SignupPageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 2,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Create Your Account\n',
                      style: Fontstyle.auth(
                        32,
                        FontWeight.bold,
                        ColorStyle.blue,
                      ),
                    ),
                    TextSpan(
                      text:
                          'Select Student or Faculty to begin your journey with our academic community.',
                      style: Fontstyle.auth(
                        14,
                        FontWeight.normal,
                        ColorStyle.lightBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
