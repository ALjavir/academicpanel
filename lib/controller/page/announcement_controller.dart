import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/department/department_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/Announcement/announcement_model.dart';

import 'package:academicpanel/model/pages/announcemrnt_page_model.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class AnnouncementController extends GetxController {
  final courseController = Get.find<CourseController>();
  final userController = Get.find<UserController>();
  final departmentController = Get.find<DepartmentController>();

  RxBool isAnnouncementLoading = false.obs;

  final List<AnnouncementModel> allAnnouncement = [];
  

  final Rx<AnnouncementPageModel> announcementPageModel = AnnouncementPageModel(
   
    newAnnNum: 0,
    totalCourse: 0,
    courseName: [],
    announcementModel: [],
    totalAnn: 0,
  ).obs;

  Future<AnnouncementPageModel> fetchAnnouncementPageModel(String state) async {
    try {
      int todayAnnouncementNum = 0;
      int numOfCurse = 0;
      int totalAnn = 0;
      final Set<String> CourseCodes = {};

      List<AnnouncementModel> tempAnnouncementList = [];
      final fetchedDataDep = await departmentController.fetchDepartmentData(
        getAnnouncement: true,
      );
      final courseModelData = await courseController.fetchSectionData(
        getAnnouncement: true,
      );
      final departAnnouncementData = fetchedDataDep.announcementModel ?? [];
      final courseAnnouncements = courseModelData.announcements ?? [];
      if (departAnnouncementData.isNotEmpty || courseAnnouncements.isNotEmpty) {
        tempAnnouncementList.addAll(departAnnouncementData);
        tempAnnouncementList.addAll(courseAnnouncements);
      }
      tempAnnouncementList.sort(
        (a, b) => b.rowAnnouncementModel.createdAt.compareTo(
          a.rowAnnouncementModel.createdAt,
        ),
      );
      allAnnouncement.addAll(tempAnnouncementList);

      if (state == "start") {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        for (var element in allAnnouncement) {
          final announcementDate = element.rowAnnouncementModel.createdAt;
          final targetDate = DateTime(
            announcementDate.year,
            announcementDate.month,
            announcementDate.day,
          );
          if (targetDate == today) {
            todayAnnouncementNum += 1;
          }
          totalAnn = allAnnouncement.length;
          CourseCodes.add(element.rowCourseModel.code);
          numOfCurse = CourseCodes.length;
          
        }
      }
      if () {
        
      }

    } catch (e) {}
  }
}
