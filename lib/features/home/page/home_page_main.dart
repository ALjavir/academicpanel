import 'package:academicpanel/navigation/appbar/custom_appbar.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';

class HomePageMain extends StatefulWidget {
  const HomePageMain({super.key});

  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: ColorStyle.light, appBar: CustomAppbar());
  }
}
