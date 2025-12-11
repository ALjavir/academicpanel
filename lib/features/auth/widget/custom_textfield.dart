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
        //print("This is printtttttting");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 1. The Container creates the "Physical" 3D shape
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          14,
        ), // Must match your TextField border radius
        boxShadow: [
          // The "Lifted" Shadow
          BoxShadow(
            color: Colors.black12, // Soft dark shadow
            // Push shadow down-right
            blurRadius: 1.6, // Softness
            spreadRadius: 0.8,
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
          errorStyle: const TextStyle(color: Colors.red, fontSize: 18),
          labelText: widget.lebalText,
          labelStyle: Fontstyle.auth(18, FontWeight.normal, ColorStyle.blue),
          floatingLabelStyle: Fontstyle.auth(
            18,
            FontWeight.normal,
            ColorStyle.lightBlue,
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
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),

          // Focused border (stay rounded)
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: ColorStyle.lightBlue, width: 1),
          ),

          // Error border
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),

          // Focused + Error border
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),

          contentPadding: const EdgeInsets.fromLTRB(
            12,
            16,
            12,
            16,
          ), // Adjusted padding slightly for better look
        ),
      ),
    );
  }
}
