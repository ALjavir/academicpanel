import 'package:academicpanel/model/Announcement/announcement_model.dart';

class AnnouncementPageModel {
  final int newAnnNum;
  final int totalCourse;
  final int totalAnn;
  final List<String> courseName;
  final List<AnnouncementModel> announcementModel;

  AnnouncementPageModel({
    required this.newAnnNum,
    required this.totalCourse,
    required this.courseName,
    required this.announcementModel,
    required this.totalAnn,
  });
}
