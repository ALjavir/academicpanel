import 'package:academicpanel/features/result/widget/result_topHeader.dart';
import 'package:academicpanel/navigation/appbar/custom_appbar.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';

class ResultPageMain extends StatefulWidget {
  const ResultPageMain({super.key});

  @override
  State<ResultPageMain> createState() => _ResultPageMainState();
}

class _ResultPageMainState extends State<ResultPageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.light,
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(child: Column(children: [ResultTopheader()])),
    );
  }
}
