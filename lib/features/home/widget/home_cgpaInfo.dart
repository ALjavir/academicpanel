import 'package:academicpanel/theme/animation/threed_containel.dart';
import 'package:flutter/material.dart';

class HomeCgpainfo extends StatefulWidget {
  const HomeCgpainfo({super.key});

  @override
  State<HomeCgpainfo> createState() => _HomeCgpainfoState();
}

class _HomeCgpainfoState extends State<HomeCgpainfo> {
  @override
  Widget build(BuildContext context) {
    return ThreeDContainel(
      hight: MediaQuery.of(context).size.height * 0.25,
      child: Text("data"),
      redious: 10,
    );
  }
}
