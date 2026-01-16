import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/department/department_controller.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/departmentSuperModel/department_model.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:get/get.dart';

class LoadAlldata extends GetxController {
  final courseController = Get.find<CourseController>();
  final departmentController = Get.find<DepartmentController>();

  SectionsuperModel? allDataSection;
  DepartmentModel? allDataDepartment;

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

  Future<void> loadAllDepartmentData() async {
    final fetchedData = await departmentController.fetchDepartmentData(
      getAcademicCalendar: true,
    );
    allDataDepartment = fetchedData;
    update();
  }
}
