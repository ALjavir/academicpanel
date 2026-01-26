import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/department/department_controller.dart';
import 'package:academicpanel/controller/result/result_controller.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/departmentSuperModel/department_model.dart';
import 'package:academicpanel/model/resultSuperModel/result_model.dart';
import 'package:academicpanel/utility/error_snackbar.dart';
import 'package:get/get.dart';

class LoadAlldata extends GetxController {
  final courseController = Get.find<CourseController>();
  final departmentController = Get.find<DepartmentController>();
  final resultController = Get.find<ResultController>();

  SectionsuperModel? allDataSection;
  DepartmentModel? allDataDepartment;
  ResultModel? allDataResult;

  Future<void> mainLoadAllData() async {
    try {
      await loadAllCourseData();
      await loadAllCourseData();
      await loadAllResultData();
    } catch (e) {
      errorSnackbar(title: "All data load Error", e: e);
    }
  }

  Future<void> loadAllCourseData() async {
    final fetchedData = await courseController.fetchSectionData(
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
      getNoCalss: true,
    );
    allDataDepartment = fetchedData;
    update();
  }

  Future<void> loadAllResultData() async {
    final fetchedData = await resultController.fetchResultData(getCGPA: true);
    allDataResult = fetchedData;
    update();
  }
}
