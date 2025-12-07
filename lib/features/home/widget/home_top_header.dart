import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';

class HomeTopHeader extends StatefulWidget {
  final HomeTopHeaderModel? homeTopHeaderModel;
  const HomeTopHeader({super.key, required this.homeTopHeaderModel});

  @override
  State<HomeTopHeader> createState() => _HomeTopHeaderState();
}

class _HomeTopHeaderState extends State<HomeTopHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.fromLTRB(10, 40, 10, 40),
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AnimationColorStyle.glassWhite,
        border: Border.all(color: Colors.white10, width: 1),
        //borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      //padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Hello, ${widget.homeTopHeaderModel!.lastName}\n',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.homeTopHeaderModel!.department,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),

                Text(
                  'ID: ${widget.homeTopHeaderModel!.id}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Text(
              widget.homeTopHeaderModel!.dateTime,
              style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
            const SizedBox(height: 5),
            Text(
              'Current Semester: ${widget.homeTopHeaderModel!.currentSmester}',
              style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
