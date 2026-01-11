import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:flutter/material.dart';

class HomeAnnouncement extends StatefulWidget {
  final List<AnnouncementModel> announcementModel;
  const HomeAnnouncement({super.key, required this.announcementModel});

  @override
  State<HomeAnnouncement> createState() => _HomeAnnouncementState();
}

class _HomeAnnouncementState extends State<HomeAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.announcementModel.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text(widget.announcementModel[index].message),
            Text(widget.announcementModel[index].date.toString()),
            Text(widget.announcementModel[index].name),
          ],
        );
      },
    );
  }
}
