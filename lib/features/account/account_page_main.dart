import 'package:academicpanel/controller/page/account_page_controller.dart';
import 'package:academicpanel/features/account/widget/accountInstallment.dart';
import 'package:academicpanel/features/account/widget/accountTopHeader/accountTopHeaderMain.dart';
import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:academicpanel/navigation/appbar/custom_appbar.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/template/animation/diagonal_reveal.dart';
import 'package:academicpanel/utility/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class AccountPageMain extends StatefulWidget {
  const AccountPageMain({super.key});

  @override
  State<AccountPageMain> createState() => _AccountPageMainState();
}

class _AccountPageMainState extends State<AccountPageMain> {
  final accountPageController = Get.put(AccountPageController());
  late Future<AccountPageModel> accountFuture;

  @override
  void initState() {
    super.initState();
    accountFuture = accountPageController.mainAccountPageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.light,
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(),
      body: DiagonalReveal(
        duration: Duration(milliseconds: 300),
        child: FutureBuilder(
          future: accountFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Loading(hight: 100));
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            final data = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  Accounttopheadermain(
                    accountPageModelTopHeader: data!.accountPageModelTopHeader,
                  ),
                  Accountinstallment(
                    accountPageModelInstallment:
                        data.accountPageModelInstallment,
                  ),
                  SizedBox(height: 100),
                ],
              ),
            );
          },
          //}
        ),
      ),
    );
  }
}
