// import 'package:academicpanel/model/home/home_model.dart';
// import 'package:academicpanel/theme/style/color_style.dart';
// import 'package:academicpanel/theme/style/font_style.dart';
// import 'package:academicpanel/theme/style/image_style.dart';
// import 'package:academicpanel/utility/loading/loading.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class HomeTopHeader extends StatefulWidget {
//   final HomeTopHeaderModel? homeTopHeaderModel;
//   const HomeTopHeader({super.key, required this.homeTopHeaderModel});

//   @override
//   State<HomeTopHeader> createState() => _HomeTopHeaderState();
// }

// class _HomeTopHeaderState extends State<HomeTopHeader> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       height: MediaQuery.of(context).size.height * 0.4,
//       width: double.maxFinite,
//       decoration: BoxDecoration(
//         color: ColorStyle.cardBlue,
//         //  colo
//         // gradient: LinearGradient(
//         //   colors: const [
//         //     Color(0xFF000046),
//         //     Color(0xFF1CB5E0),
//         //     // Color(0xFFec38bc),
//         //     // Color(0xFFfdeff9),
//         //   ],

//         //   begin: Alignment.topLeft,
//         //   end: Alignment.bottomRight,
//         // ),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.white10, width: 1),
//         //borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             spreadRadius: 3,
//             // offset: const Offset(3, 3),
//           ),
//         ],
//       ),
//       //padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 // 1. Use 'shape: BoxShape.circle' for a perfect round border
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.black12, width: 2),
//                 ),

//                 // 2. ClipOval forces the child (the image) to be round
//                 child: ClipOval(
//                   child: SizedBox.fromSize(
//                     size: const Size.fromRadius(
//                       50,
//                     ), // Matches your radius 50 (total 100px)
//                     child:
//                         (widget.homeTopHeaderModel?.image != null &&
//                             widget.homeTopHeaderModel!.image!.isNotEmpty)
//                         ? CachedNetworkImage(
//                             imageUrl: widget.homeTopHeaderModel!.image!,
//                             fit: BoxFit
//                                 .cover, // <--- CRITICAL: Makes image fill the circle
//                             progressIndicatorBuilder: (context, url, progress) {
//                               return const Center(child: Loading(hight: 40));
//                             },
//                             // Optional: What if the URL is not null but the image fails to load?
//                             errorWidget: (context, url, error) => Image.asset(
//                               ImageStyle.noImage(),
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                         : Image.asset(
//                             ImageStyle.noImage(), // <--- Your Asset Image Here
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                 ),
//               ),
//               Column(
//                 children: [
//                   Text(
//                     'Hello, ${widget.homeTopHeaderModel!.lastName}\n',
//                     style: Fontstyle.defult(
//                       22,
//                       FontWeight.bold,
//                       ColorStyle.light,
//                     ),
//                   ),
//                   Text(
//                     widget.homeTopHeaderModel!.department,
//                     style: const TextStyle(fontSize: 16, color: Colors.grey),
//                   ),

//                   Text(
//                     'ID: ${widget.homeTopHeaderModel!.id}',
//                     style: const TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           const SizedBox(height: 10),
//           Text(
//             widget.homeTopHeaderModel!.dateTime,
//             style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
//           ),
//           const SizedBox(height: 5),
//           Text(
//             'Current Semester: ${widget.homeTopHeaderModel!.currentSmester}',
//             style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
//           ),
//         ],
//       ),
//     );
//   }
// }
