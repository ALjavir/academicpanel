import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';

class SectionsuperModel {
  final List<ClassscheduleModel>? schedules;
  final List<AnnouncementModel>? announcements;

  SectionsuperModel({this.schedules, this.announcements});
}
