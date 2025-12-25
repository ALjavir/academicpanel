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
      padding: EdgeInsets.fromLTRB(10, 60, 10, 30),
      decoration: BoxDecoration(
        //  color: ColorStyle.Textblue,
        image: DecorationImage(
          fit: BoxFit.cover,

          image: AssetImage(ImageStyle.topHomePageBackGround()),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
            spreadRadius: 3,
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(10),
        child: BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          blendMode: BlendMode.src,

          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                ClipOval(
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
                              ImageStyle.noProfileImageIcon(),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            ImageStyle.noProfileImageIcon(), // <--- Your Asset Image Here
                            fit: BoxFit.cover,
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
                            // const Color.fromARGB(20, 19, 70, 125),
                            // const Offset(3, 3),
                            // 4,
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
