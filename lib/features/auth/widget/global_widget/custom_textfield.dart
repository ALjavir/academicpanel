import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  String? errorText;

  final double fontsize;
  final FontWeight fontWeight;
  int maxline;

  final Function() validateFields;

  CustomTextfield({
    super.key,
    required this.textController,
    required this.hintText,
    required this.validateFields,
    required this.errorText,

    required this.maxline,
    required this.fontsize,
    required this.fontWeight,
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
      cursorColor: Colors.white,
      focusNode: nameFocusNode,
      style: Fontstyle.auth(
        widget.fontsize,
        widget.fontWeight,
        ColorStyle.lightBlue,
      ),
      maxLines: widget.maxline,

      decoration: InputDecoration(
        errorText: widget.errorText,
        errorStyle: TextStyle(color: Colors.red, fontSize: 18),

        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white70, fontSize: 24),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white30),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        contentPadding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
      ),
    );
  }
}
