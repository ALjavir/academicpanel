import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:get/get.dart';

class LoadAlldata extends GetxController {
  CourseController courseController = Get.put(CourseController());
  SectionsuperModel? allDataSection;

  Future<void> loadAllCourseData(UserModel userModel) async {
    final fetchedData = await courseController.fetchSectionData(
      userModel: userModel,
      getAnnouncement: true,
      getAssessment: true,
      getClassSchedule: true,
    );

    allDataSection = fetchedData;
    update();
  }
}
