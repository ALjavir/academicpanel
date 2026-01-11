import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';

class ScheduleandannouncementModel {
  final List<ClassscheduleModel> schedules;
  final List<AnnouncementModel> announcements;

  ScheduleandannouncementModel({
    required this.schedules,
    required this.announcements,
  });
}
