import 'package:academicpanel/controller/auth/signup_controller.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatefulWidget {
  final Future<void> Function() onPressed;
  final String text;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await widget.onPressed();
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: ColorStyle.blue,
        foregroundColor: ColorStyle.lightBlue,
        padding: EdgeInsets.all(10),
        //fixedSize: Size(250, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 1, color: Colors.white),
        ),
      ),
      label: Text(
        widget.text,
        style: Fontstyle.auth(20, FontWeight.w500, Colors.white),
      ),

      icon: Icon(Icons.arrow_forward_outlined, color: Colors.white),
      iconAlignment: IconAlignment.end,
    );
  }
}
