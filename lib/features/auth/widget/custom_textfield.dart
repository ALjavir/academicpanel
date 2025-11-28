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
    return TextField(
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
        hintStyle: Fontstyle.auth(16, FontWeight.normal, ColorStyle.lightBlue),

        // Normal border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.black12, width: 1),
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

        contentPadding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
      ),
    );
  }
}
