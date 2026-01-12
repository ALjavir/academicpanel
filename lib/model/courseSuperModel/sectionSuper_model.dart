import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';

class SectionsuperModel {
  final List<ClassscheduleModel>? schedules;
  final List<AnnouncementModel>? announcements;
  final List<AssessmentModel>? assessment;

  SectionsuperModel({this.schedules, this.announcements, this.assessment});
}
