import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final String? errorText;
  final String lebalText;
  final bool obscureText;
  final Widget? suffixIconFun;

  final int maxline;

  final Function() validateFields;

  const CustomTextfield({
    super.key,
    required this.textController,
    required this.hintText,
    required this.validateFields,
    required this.errorText,

    required this.maxline,

    required this.lebalText,
    required this.obscureText,
    this.suffixIconFun,
  });

  @override
  State<CustomTextfield> createState() => _TextFieldState();
}

class _TextFieldState extends State<CustomTextfield> {
  final FocusNode nameFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    nameFocusNode.addListener(() {
      if (!nameFocusNode.hasFocus) {
        widget.validateFields();
      }
      // else {
      //   print(
      //     "-----------------------------------------------------------------This is printtttttting",
      //   );
      //   // Field has gained focus
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 1. The Container creates the "Physical" 3D shape
      decoration: BoxDecoration(
        color: ColorStyle.light,
        borderRadius: BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(8, 0, 0, 0), // Soft dark shadow
            blurRadius: 4,
            offset: Offset(4, 4), // Softness
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextField(
        textAlign: TextAlign.justify,
        controller: widget.textController,
        cursorColor: ColorStyle.Textblue,
        focusNode: nameFocusNode,
        style: Fontstyle.defult(18, FontWeight.w500, ColorStyle.Textblue),
        maxLines: widget.maxline,
        obscureText: widget.obscureText,

        decoration: InputDecoration(
          suffixIcon: widget.suffixIconFun,
          errorText: widget.errorText,
          errorStyle: Fontstyle.errorSnackBar(
            16,
            const Color.fromARGB(150, 244, 67, 54),
            FontWeight.w500,
          ),
          labelText: widget.lebalText,
          labelStyle: Fontstyle.defult(
            18,
            FontWeight.normal,
            ColorStyle.Textblue,
          ),
          floatingLabelStyle: Fontstyle.defult(
            18,
            FontWeight.normal,
            ColorStyle.Textblue,
          ),
          hintText: widget.hintText,
          hintStyle: Fontstyle.defult(
            16,
            FontWeight.normal,
            ColorStyle.lightBlue,
          ),

          // IMPORTANT: Set fill color to transparent so the Container's 3D effect shows through
          filled: true,
          fillColor: Colors.transparent,

          // Normal border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color.fromARGB(16, 0, 0, 0),
              width: 1,
            ),
          ),

          // Focused border (stay rounded)
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: ColorStyle.lightBlue, width: 1),
          ),

          // Error border
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),

          // Focused + Error border
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),

            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),

          contentPadding: const EdgeInsets.fromLTRB(
            12,
            16,
            12,
            18,
          ), // Adjusted padding slightly for better look
        ),
      ),
    );
  }
}
