import 'package:academicpanel/features/account/widget/accountTopHeader.dart';
import 'package:academicpanel/navigation/appbar/custom_appbar.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/template/animation/diagonal_reveal.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AccountPageMain extends StatefulWidget {
  const AccountPageMain({super.key});

  @override
  State<AccountPageMain> createState() => _AccountPageMainState();
}

class _AccountPageMainState extends State<AccountPageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.light,
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(),
      body: DiagonalReveal(
        duration: Duration(milliseconds: 300),
        child: Obx(
          () {
            // if (resultPageController.isLoading.value) {
            //   return const Center(child: Loading(hight: 100));
            // } else {
            return SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [Accounttopheader(), SizedBox(height: 100)],
              ),
            );
          },
          //}
        ),
      ),
    );
  }
}
