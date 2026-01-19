import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/department/department_controller.dart';
import 'package:academicpanel/controller/helper/helper.dart';
import 'package:academicpanel/controller/masterController/load_allData.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/departmentSuperModel/department_model.dart';
import 'package:academicpanel/model/departmentSuperModel/noClass_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_noClass_model.dart';
import 'package:academicpanel/model/pages/schedule_page_model.dart';
import 'package:academicpanel/utility/error_widget/error_snackbar.dart';
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

  RxList<AssessmentModel> assessmentschedule = RxList<AssessmentModel>();

  @override
  void onInit() {
    super.onInit();
    // Fetch today's data immediately when app starts
    final focusedDate = DateTime.now().obs;

    fetchclassScheduleCalander(focusedDate.value);
    fetchAssment('CHE-101');
  }

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
              if (Helper.isDateInRange(date, i.startDate!, i.endDate!)) {
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

  Future<List<AssessmentModel>> fetchAssment(String sortBy) async {
    // sortBy can be: "complete", "incomplete", or a course code like "CSE101"
    try {
      // 1. Clear previous list
      assessmentschedule.clear();

      SectionsuperModel assessmentData;
      final userModel = userController.user.value;

      // 2. Fetch or Load Data
      if (loadAlldata.allDataSection?.assessment == null ||
          loadAlldata.allDataSection!.assessment!.isEmpty) {
        final fetchedData = await courseController.fetchSectionData(
          userModel: userModel!,
          getAssessment: true,
        );
        assessmentData = fetchedData;
      } else {
        assessmentData = loadAlldata.allDataSection!;
      }

      // 3. Filter Data
      if (assessmentData.assessment != null) {
        final assessmentList = assessmentData.assessment!;
        final now = DateTime.now();

        // Normalize 'Today' to midnight for accurate date comparison
        final today = DateTime(now.year, now.month, now.day);

        for (var item in assessmentList) {
          // Normalize item date to midnight
          final DateTime itemDate = item.date;
          final DateTime eventDay = DateTime(
            itemDate.year,
            itemDate.month,
            itemDate.day,
          );

          bool shouldAdd = false;

          if (sortBy == "complete") {
            // CASE 1: Filter by Status "Complete" (Strictly Past)
            if (eventDay.isBefore(today)) {
              shouldAdd = true;
            }
          } else if (sortBy == "incomplete") {
            // CASE 2: Filter by Status "Incomplete" (Today or Future)
            if (eventDay.isAtSameMomentAs(today) || eventDay.isAfter(today)) {
              shouldAdd = true;
            }
          } else {
            // CASE 3: Filter by Course Code (e.g., "CSE101")
            // If it's not "complete" or "incomplete", we assume it's a code.

            if (item.rowCourseModel.code == sortBy) {
              shouldAdd = true;
            }
          }

          // Add to list if it matched the criteria
          if (shouldAdd) {
            assessmentschedule.add(item);
          }
        }
      }

      return assessmentschedule;
    } catch (e) {
      print("Error fetching Assessment: $e");
      return [];
    }
  }
}
