import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/theme/animation/animation_theme.dart';
import 'package:academicpanel/navigation/appbar/custom_appbar.dart';
import 'package:academicpanel/theme/shadow_container/shadow_container.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

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
      //backgroundColor: ColorStyle.light,

      //appBar: CustomAppbar(),
      body: AnimationTheme(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
          child: Column(
            children: [
              ShadowContainer(child: Text("data")),
              CachedNetworkImage(imageUrl: user!.image!),
              Text(user.uid!),
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
      ),
    );
  }
}
