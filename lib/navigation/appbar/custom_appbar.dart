import 'dart:ui';

import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.all(0),
      elevation: 5,
      shadowColor: Colors.black26,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
            tileMode: TileMode.clamp,
          ),
          child: AppBar(
            forceMaterialTransparency: true,
            titleSpacing: 0,
            leadingWidth: 5,
            leading: SizedBox.shrink(),
            title: Row(
              children: [
                SvgPicture.asset(ImageStyle.logo(), height: 80),
                Text('PRESIDENCY\nUNIVERSITY', style: Fontstyle.splashS(18)),
              ],
            ),
            actions: [
              //    Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Obx(
              //     () => InkWell(
              //       onTap: () async {
              //         Get.dialog(Center(child: Loading()));

              //         await bcagx.placeTheOrder(false);

              //         Get.back();

              //         Get.to(() => CartpageMain(cartItemsChecked: bcagx.cartItems));
              //       },
              //       child: bcagx.cartItems.isEmpty
              //           ? Image.asset(IconStyle.CartEmtyIcon(), scale: 16)
              //           : Stack(
              //               alignment: Alignment.center,
              //               children: [
              //                 Image.asset(
              //                   IconStyle.CartFinalIcon(),
              //                   scale: 16,
              //                   color: Color(0xffCA1212),
              //                 ),
              //                 Text(
              //                   "${bcagx.cartItems.length}  ".toString(),
              //                   style: Fontstyle.dis2front(18, Colors.white),
              //                 ),
              //               ],
              //             ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
