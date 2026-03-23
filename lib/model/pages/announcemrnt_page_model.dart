import 'package:academicpanel/model/Announcement/announcement_model.dart';

class AnnouncementPageModel {
  int newAnnNum;
  int totalCourse;
  int totalAnn;
  List<String> courseName;
  List<AnnouncementModel> announcementModel;

  AnnouncementPageModel({
    required this.newAnnNum,
    required this.totalCourse,
    required this.courseName,
    required this.announcementModel,
    required this.totalAnn,
  });
}
