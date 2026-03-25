import 'package:academicpanel/model/Announcement/announcement_model.dart';

class AnnouncementPageAnnList {
  List<String> courseName;
  List<AnnouncementModel> announcementModel;

  AnnouncementPageAnnList({
    required this.courseName,
    required this.announcementModel,
  });
}

class AnnouncementPageTopHeader {
  int newAnnNum;
  int totalCourse;
  int totalAnn;
  AnnouncementPageTopHeader({
    required this.totalAnn,
    required this.newAnnNum,
    required this.totalCourse,
  });
}
