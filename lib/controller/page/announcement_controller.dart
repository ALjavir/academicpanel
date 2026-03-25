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

  RxBool isAnnouncementLoadingFull = false.obs;
  RxBool isAnnouncementLoadingList = false.obs;

  final AnnouncementPageTopHeader announcementPageTopHeader =
      AnnouncementPageTopHeader(totalAnn: 0, newAnnNum: 0, totalCourse: 0);
  final Rx<AnnouncementPageAnnList> announcementPageModel =
      AnnouncementPageAnnList(courseName: [], announcementModel: []).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isAnnouncementLoadingFull.value = true;
    await Future.wait([fetchAnnouncementPageModel("start")]);
    isAnnouncementLoadingFull.value = false;
  }

  Future fetchAnnouncementPageModel(String sortBy) async {
    final model = announcementPageModel.value;
    try {
      isAnnouncementLoadingList.value = true;
      final results = await Future.wait([
        departmentController.fetchDepartmentData(getAnnouncement: true),
        courseController.fetchSectionData(getAnnouncement: true),
      ]);

      final departAnnouncementData =
          (results[0] as DepartmentModel).announcementModel ?? [];
      final courseAnnouncements =
          (results[1] as SectionsuperModel).announcements ?? [];

      final Map<String, AnnouncementModel> uniqueAnnouncements = {};

      for (var item in departAnnouncementData) {
        final uniqueKey = item.rowAnnouncementModel.message;
        uniqueAnnouncements[uniqueKey] = item;
      }

      for (var item in courseAnnouncements) {
        final uniqueKey = item.rowAnnouncementModel.message;
        uniqueAnnouncements[uniqueKey] = item;
      }

      List<AnnouncementModel> allAnnouncementList = uniqueAnnouncements.values
          .toList();

      int newAnnNum = 0;
      int totalAnn = 0;
      final Set<String> courseName = {"Latest"};
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      for (var element in allAnnouncementList) {
        courseName.add(element.rowCourseModel.code);

        final date = element.rowAnnouncementModel.createdAt;
        if (DateTime(date.year, date.month, date.day) == today) {
          newAnnNum += 1;
        }
      }

      List<AnnouncementModel> startList = [];
      //List<AnnouncementModel> filteredList = [];

      if (sortBy == "start" || sortBy == "Latest") {
        startList = List.from(allAnnouncementList);
        totalAnn = startList.length;

        announcementPageTopHeader.newAnnNum = newAnnNum;
        announcementPageTopHeader.totalAnn = totalAnn;
        announcementPageTopHeader.totalCourse = courseName.length;
      } else {
        startList = allAnnouncementList.where((element) {
          return element.rowCourseModel.code == sortBy;
        }).toList();
      }

      startList.sort(
        (a, b) => b.rowAnnouncementModel.createdAt.compareTo(
          a.rowAnnouncementModel.createdAt,
        ),
      );

      model.courseName = courseName.toList();
      model.announcementModel = startList;

      isAnnouncementLoadingList.value = false;

      return model;
    } catch (e) {
      isAnnouncementLoadingFull.value = false;

      return model;
    }
  }
}
