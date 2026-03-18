import 'package:academicpanel/model/Announcement/row_announcement_model.dart';
import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';

class AnnouncementModel {
  final RowAnnouncementModel rowAnnouncementModel;
  final RowCourseModel rowCourseModel;
  final String whatsApp;
  AnnouncementModel({
    required this.rowCourseModel,
    required this.rowAnnouncementModel,
    required this.whatsApp,
  });
}
