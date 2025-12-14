import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: () async {
        await widget.onPressed();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: ColorStyle.blue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(30, 0, 0, 0), // Soft dark shadow
              blurRadius: 3,
              offset: Offset(3, 3), // Softness
              spreadRadius: 1.5,
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: Fontstyle.auth(20, FontWeight.w600, Colors.white),
            ),
            Icon(Icons.arrow_forward_outlined, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
