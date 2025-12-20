import 'dart:ui';

import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/utility/loading/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeTopHeader2 extends StatefulWidget {
  final HomeTopHeaderModel homeTopHeaderModel;
  const HomeTopHeader2({super.key, required this.homeTopHeaderModel});

  @override
  State<HomeTopHeader2> createState() => _HomeTopHeader2State();
}

class _HomeTopHeader2State extends State<HomeTopHeader2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
      decoration: BoxDecoration(
        //  color: ColorStyle.Textblue,
        gradient: LinearGradient(
          tileMode: TileMode.decal,
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          colors: [
            Color(0xff021B79), Color(0xff0575E6),
            //Color(0xfff6f6f6)
          ],
        ),
      ),

      child: Container(
        padding: EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: ColorStyle.glassWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(12, 255, 255, 255),

              blurRadius: 6,

              // offset: Offset(0, 6), // Softness
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      20,
                      19,
                      70,
                      125,
                    ), // Soft dark shadow
                    blurRadius: 4,
                    // offset: Offset(6, 6), // Softness
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(
                    32,
                  ), // Matches your radius 50 (total 100px)
                  child:
                      (widget.homeTopHeaderModel.image != null &&
                          widget.homeTopHeaderModel.image!.isNotEmpty)
                      ? CachedNetworkImage(
                          imageUrl: widget.homeTopHeaderModel.image!,
                          fit: BoxFit
                              .cover, // <--- CRITICAL: Makes image fill the circle
                          progressIndicatorBuilder: (context, url, progress) {
                            return const Center(child: Loading(hight: 40));
                          },
                          // Optional: What if the URL is not null but the image fails to load?
                          errorWidget: (context, url, error) => Image.asset(
                            ImageStyle.noImage(),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          ImageStyle.noImage(), // <--- Your Asset Image Here
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Hello, ${widget.homeTopHeaderModel.lastName}',

                  style: Fontstyle.defult3d(
                    22,
                    FontWeight.bold,
                    ColorStyle.light,
                    const Color.fromARGB(20, 19, 70, 125),
                    const Offset(3, 3),
                    4,
                  ),
                ),
                Row(
                  spacing: 5,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      widget.homeTopHeaderModel.date,

                      style: Fontstyle.defult3d(
                        14,
                        FontWeight.w600,
                        ColorStyle.light,
                        const Color.fromARGB(20, 19, 70, 125),
                        const Offset(3, 3),
                        4,
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

                      style: Fontstyle.defult3d(
                        14,
                        FontWeight.w600,
                        ColorStyle.light,
                        const Color.fromARGB(20, 19, 70, 125),
                        const Offset(3, 3),
                        4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
