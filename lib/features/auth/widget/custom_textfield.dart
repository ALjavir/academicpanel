import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final String? errorText;
  final String lebalText;

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
            color: const Color.fromARGB(10, 0, 0, 0), // Soft dark shadow
            blurRadius: 3,
            offset: Offset(3, 3), // Softness
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: TextField(
        textAlign: TextAlign.justify,
        controller: widget.textController,
        cursorColor: ColorStyle.blue,
        focusNode: nameFocusNode,
        style: Fontstyle.auth(18, FontWeight.w500, ColorStyle.blue),
        maxLines: widget.maxline,

        decoration: InputDecoration(
          errorText: widget.errorText,
          errorStyle: Fontstyle.errorSnackBar(
            16,
            const Color.fromARGB(150, 244, 67, 54),
            FontWeight.w500,
          ),
          labelText: widget.lebalText,
          labelStyle: Fontstyle.auth(18, FontWeight.normal, ColorStyle.blue),
          floatingLabelStyle: Fontstyle.auth(
            18,
            FontWeight.normal,
            ColorStyle.blue,
          ),
          hintText: widget.hintText,
          hintStyle: Fontstyle.auth(
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
              color: Color.fromARGB(20, 0, 0, 0),
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
