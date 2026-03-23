import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/department/department_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/departmentSuperModel/department_model.dart';

import 'package:academicpanel/model/pages/announcemrnt_page_model.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class AnnouncementController extends GetxController {
  final courseController = Get.find<CourseController>();
  final userController = Get.find<UserController>();
  final departmentController = Get.find<DepartmentController>();

  RxBool isAnnouncementLoading = false.obs;

  final Rx<AnnouncementPageModel> announcementPageModel = AnnouncementPageModel(
    newAnnNum: 0,
    totalCourse: 0,
    courseName: [],
    announcementModel: [],
    totalAnn: 0,
  ).obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await Future.wait([fetchAnnouncementPageModel("start")]);
  }

  Future<AnnouncementPageModel> fetchAnnouncementPageModel(
    String sortBy,
  ) async {
    final model = announcementPageModel.value;
    try {
      isAnnouncementLoading.value = true;
      final results = await Future.wait([
        departmentController.fetchDepartmentData(getAnnouncement: true),
        courseController.fetchSectionData(getAnnouncement: true),
      ]);
      final departAnnouncementData =
          (results[0] as DepartmentModel).announcementModel ?? [];
      final courseAnnouncements =
          (results[1] as SectionsuperModel).announcements ?? [];

      List<AnnouncementModel> allAnnouncementList = [
        ...departAnnouncementData,
        ...courseAnnouncements,
      ];

      int newAnnNum = 0;
      final Set<String> courseName = {};
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      for (var element in allAnnouncementList) {
        courseName.add(element.rowCourseModel.code);

        final date = element.rowAnnouncementModel.createdAt;
        if (DateTime(date.year, date.month, date.day) == today) {
          newAnnNum += 1;
        }
      }

      List<AnnouncementModel> filteredList = [];

      if (sortBy == "start" || sortBy == "Latest") {
        filteredList = List.from(allAnnouncementList);
      } else {
        filteredList = allAnnouncementList.where((element) {
          return element.rowCourseModel.code == sortBy;
        }).toList();
      }

      filteredList.sort(
        (a, b) => b.rowAnnouncementModel.createdAt.compareTo(
          a.rowAnnouncementModel.createdAt,
        ),
      );

      model.newAnnNum = newAnnNum;
      model.totalCourse = courseName.length;
      model.courseName = courseName.toList();
      model.announcementModel = filteredList;
      model.totalAnn = filteredList.length;

      isAnnouncementLoading.value = false;

      return model;
    } catch (e) {
      isAnnouncementLoading.value = false;
      return model;
    }
  }
}
