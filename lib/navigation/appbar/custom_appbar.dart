import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? leading;
  const CustomAppbar({super.key, this.leading});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      centerTitle: true,

      title: Text('Presidency\nUniversity', style: Fontstyle.splashS(32)),
      leading: SvgPicture.asset(ImageStyle.logo()),
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
    );
  }
}
