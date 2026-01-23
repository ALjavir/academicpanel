import 'dart:ui';

import 'package:academicpanel/model/pages/home_page_model.dart';
import 'package:academicpanel/theme/template/animation/threeD_containerHead.dart';

import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/utility/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class HomeTopHeader extends StatefulWidget {
  final HomeTopHeaderModel homeTopHeaderModel;
  const HomeTopHeader({super.key, required this.homeTopHeaderModel});

  @override
  State<HomeTopHeader> createState() => _HomeTopHeaderState();
}

class _HomeTopHeaderState extends State<HomeTopHeader> {
  @override
  Widget build(BuildContext context) {
    bool hasImage =
        widget.homeTopHeaderModel.image != null &&
            widget.homeTopHeaderModel.image!.isNotEmpty
        ? true
        : false;
    return ThreedContainerhead(
      padding: EdgeInsets.fromLTRB(10, 60, 10, 30),
      imagePath: ImageStyle.topHomePageBackGround(),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          blendMode: BlendMode.srcOver,
          child: Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white54),
              borderRadius: BorderRadius.circular(10),
              color: ColorStyle.glassWhite,
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Container(
                  height: 65,
                  width: 65,

                  clipBehavior: Clip.antiAliasWithSaveLayer,

                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),

                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 0.8, color: Colors.white70),
                  ),

                  child: hasImage
                      ? CachedNetworkImage(
                          imageUrl: widget.homeTopHeaderModel.image!,

                          fit: BoxFit.cover,

                          progressIndicatorBuilder: (context, url, progress) {
                            return const Center(child: Loading(hight: 40));
                          },
                          errorWidget: (context, url, error) => Image.asset(
                            ImageStyle.noProfileImageIcon(),
                            fit: BoxFit.contain,
                            scale: 20,
                          ),
                        )
                      : Image.asset(
                          ImageStyle.noProfileImageIcon(),
                          fit: BoxFit.contain,
                          scale: 20,
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Hello, ${widget.homeTopHeaderModel.lastName.capitalizeFirst!}',

                      style: Fontstyle.defult(
                        22,
                        FontWeight.bold,
                        ColorStyle.light,
                      ),
                    ),
                    Row(
                      spacing: 5,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          widget.homeTopHeaderModel.date,

                          style: Fontstyle.defult(
                            14,
                            FontWeight.w600,
                            ColorStyle.light,
                            // const Color.fromARGB(20, 19, 70, 125),
                            //  const Offset(3, 3),
                            // 4,
                          ),
                        ),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: ColorStyle.light,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          widget.homeTopHeaderModel.semester,

                          style: Fontstyle.defult(
                            14,
                            FontWeight.w600,
                            ColorStyle.light,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
