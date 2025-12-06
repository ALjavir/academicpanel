import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';

class HomeTopHeader extends StatefulWidget {
  final HomeTopHeaderModel homeTopHeaderModel;
  const HomeTopHeader({super.key, required this.homeTopHeaderModel});

  @override
  State<HomeTopHeader> createState() => _HomeTopHeaderState();
}

class _HomeTopHeaderState extends State<HomeTopHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorStyle.blue,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back, ${widget.homeTopHeaderModel.lastName}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            widget.homeTopHeaderModel.department,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          Text(
            'ID: ${widget.homeTopHeaderModel.id}',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            widget.homeTopHeaderModel.dateTime,
            style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
          ),
          const SizedBox(height: 5),
          Text(
            'Current Semester: ${widget.homeTopHeaderModel.currentSmester}',
            style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
