import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/department/department_controller.dart';

import 'package:academicpanel/controller/masterController/load_allData.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/departmentSuperModel/department_model.dart';
import 'package:academicpanel/model/departmentSuperModel/noClass_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:academicpanel/model/pages/schedule_page_model.dart';
import 'package:academicpanel/theme/style/date_In_range.dart';
import 'package:academicpanel/utility/error_snackbar.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class SchedulePageContoller extends GetxController {
  final userController = Get.find<UserController>();
  final loadAlldata = Get.find<LoadAlldata>();
  final courseController = Get.find<CourseController>();
  final departmentController = Get.find<DepartmentController>();

  final Rx<ClassSchedulePageSchedule> classSchedulePageSchedule =
      ClassSchedulePageSchedule(days: [], classSchedule: []).obs;
  List<RowAcademiccalendarModel> academicCalendarData = [];

  final Rx<AssessmentPageSchedule> assessmentschedulePage =
      AssessmentPageSchedule(assessmentModel: [], courseCode: []).obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch today's data immediately when app starts
    final focusedDate = DateTime.now().obs;

    fetchclassScheduleCalander(focusedDate.value);
    fetchAssessment(sortBy: 'incomplete');
  }

  // A: --------------------------------------------------------------------------Class Schedule Calander----------------------------------------------------------------------
  Future<ClassSchedulePageSchedule> fetchclassScheduleCalander(
    DateTime date,
  ) async {
    final userModel = userController.user.value;
    final model = classSchedulePageSchedule.value;
    model.noClass = null;
    final days = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];

    String dayKey = days[date.weekday - 1];

    if (userModel?.current_course?.isEmpty ?? true) {
      return model;
    }
    try {
      SectionsuperModel? classScheduleData;

      if (classSchedulePageSchedule.value.classSchedule.isEmpty) {
        DepartmentModel noCLassData;

        if (loadAlldata.allDataDepartment?.rowNoclassModel == null ||
            loadAlldata.allDataDepartment!.rowNoclassModel!.isEmpty) {
          final fetchedData = await departmentController.fetchDepartmentData(
            getNoCalss: true,
          );
          noCLassData = fetchedData;

          if (noCLassData.rowNoclassModel != null) {
            for (var i in noCLassData.rowNoclassModel!) {
              // Holiday Check
              if (DateInRange.isDateInRange(date, i.startDate!, i.endDate!)) {
                classSchedulePageSchedule.value.noClass = NoclassModel(
                  title: i.title!,
                  startDate: i.startDate!,
                  endDate: i.endDate!,
                  type: i.type!,
                );

                classSchedulePageSchedule.refresh();
                return classSchedulePageSchedule.value;
              }
            }
          }
        }
      }
      if (loadAlldata.allDataSection?.schedules == null ||
          loadAlldata.allDataSection!.schedules!.isEmpty) {
        classScheduleData = await courseController.fetchSectionData(
          userModel: userModel!,
          getClassSchedule: true,
        );
        loadAlldata.allDataSection = classScheduleData;
      } else {
        classScheduleData = loadAlldata.allDataSection!;
      }

      model.classSchedule.clear();
      bool shouldPopulateDays = model.days.isEmpty;

      if (classScheduleData.schedules != null) {
        for (var i in classScheduleData.schedules!) {
          if (shouldPopulateDays) {
            model.days.add(i.day);
          }

          if (i.day == dayKey) {
            model.classSchedule.add(i);
          }
        }

        // Sort days only once
        if (shouldPopulateDays) {
          model.days.sort();
        }
      }

      print("Selected day: $dayKey");
      print("Classes found: ${model.classSchedule.length}");

      classSchedulePageSchedule.refresh();
      return model;
    } catch (e) {
      errorSnackbar(title: "class Schedule Data Fetching Error", e: e);
      return model;
    }
  }

  // B: --------------------------------------------------------------------------Academic Calendar----------------------------------------------------------------------
  Future<List<RowAcademiccalendarModel>> fetchAcademicCalendar() async {
    try {
      if (loadAlldata.allDataDepartment?.academiccalendarModel == null ||
          loadAlldata.allDataDepartment!.academiccalendarModel!.isEmpty) {
        final fetchData = await departmentController.fetchDepartmentData(
          getAcademicCalendar: true,
        );
        academicCalendarData = fetchData.academiccalendarModel ?? [];
      } else {
        print("Data found in Cache (loadAlldata). Using it.");
        academicCalendarData =
            loadAlldata.allDataDepartment!.academiccalendarModel!;
      }
      return academicCalendarData;
    } catch (e) {
      errorSnackbar(title: "Academic Calendar data Fetching Error", e: e);
      return [];
    }
  }

  // C: --------------------------------------------------------------------------Assessment----------------------------------------------------------------------
  Future<AssessmentPageSchedule> fetchAssessment({
    String sortBy = 'default',
  }) async {
    try {
      assessmentschedulePage.value.assessmentModel.clear();
      assessmentschedulePage.value.courseCode.clear();

      SectionsuperModel assessmentData;
      final userModel = userController.user.value;

      assessmentschedulePage.value.courseCode.addAll(
        userModel!.current_course!.values,
      );

      if (loadAlldata.allDataSection?.assessment == null ||
          loadAlldata.allDataSection!.assessment!.isEmpty) {
        final fetchedData = await courseController.fetchSectionData(
          userModel: userModel,
          getAssessment: true,
        );
        assessmentData = fetchedData;
      } else {
        assessmentData = loadAlldata.allDataSection!;
      }

      if (assessmentData.assessment != null) {
        final assessmentList = assessmentData.assessment!;
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        for (var item in assessmentList) {
          // Normalize item date to midnight for accurate comparison
          final DateTime itemDate = item.startTime;
          final DateTime eventDay = DateTime(
            itemDate.year,
            itemDate.month,
            itemDate.day,
          );

          bool shouldAdd = false;

          if (sortBy == "complete") {
            if (eventDay.isBefore(today)) {
              shouldAdd = true;
            }
          } else if (sortBy == "incomplete") {
            if (!eventDay.isBefore(today)) {
              shouldAdd = true;
            }
          } else if (sortBy == 'default') {
            shouldAdd = true;
          } else {
            if (item.rowCourseModel.code == sortBy) {
              shouldAdd = true;
            }
          }

          if (shouldAdd) {
            assessmentschedulePage.value.assessmentModel.add(item);
          }
        }
      }
      List<AssessmentModel> finalAssessmentschedulePage = [];
      if (sortBy == 'complete') {
        finalAssessmentschedulePage = assessmentschedulePage
            .value
            .assessmentModel
            .toList();
      } else {
        finalAssessmentschedulePage = assessmentschedulePage
            .value
            .assessmentModel
            .reversed
            .toList();
      }

      assessmentschedulePage.value.assessmentModel =
          finalAssessmentschedulePage;
      return assessmentschedulePage.value;
    } catch (e) {
      print("Error fetching Assessment: $e");
      return assessmentschedulePage.value;
    }
  }
}

 // A: --------------------------------------------------------------------------HOME TOP HEADER----------------------------------------------------------------------