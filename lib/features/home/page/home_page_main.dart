import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/navigation/appbar/custom_appbar.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/utility/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class HomePageMain extends StatefulWidget {
  const HomePageMain({super.key});

  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  final userController = Get.find<UserController>();
  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    final user = userController.user.value;
    return Scaffold(
      backgroundColor: ColorStyle.light,
      appBar: CustomAppbar(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(user!.uid!),
            Text(user.id.toString()),
            Text(user.firstName),
            Text(user.lastName),
            Text(user.email),
            Text(user.password),
            Text(user.department),
            Text(user.phone.toString()),
            //  Text(storage.write(key: 'key', value: 'value'as String)

            //Text(user.courses!.entries as String),
          ],
        ),
      ),
    );
  }
}
