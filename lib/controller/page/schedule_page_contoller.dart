import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/department/department_controller.dart';

import 'package:academicpanel/controller/masterController/load_allData.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/departmentSuperModel/department_model.dart';
import 'package:academicpanel/model/departmentSuperModel/noClass_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:academicpanel/model/pages/schedule_page_model.dart';
import 'package:academicpanel/theme/style/dateTime_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';

import 'package:academicpanel/utility/error_snackbar.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class SchedulePageContoller extends GetxController {
  final userController = Get.find<UserController>();
  // final loadAlldata = Get.find<LoadAlldata>();
  final courseController = Get.find<CourseController>();
  final departmentController = Get.find<DepartmentController>();

  RxBool isLoading = true.obs;

  RxBool isLoadingClassSchdule = true.obs;

  final Rx<SchedulePageTopHeader> schedulePageTopHeader = SchedulePageTopHeader(
    days: [],
    image: '',
    curentMonth: [],
  ).obs;

  final Rx<ClassSchedulePageSchedule> classSchedulePage =
      ClassSchedulePageSchedule(
        classSchedule: [],
        noClass: NoclassModel(
          title: '',
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          type: "",
        ),
      ).obs;

  final RxList<RowAcademiccalendarModel> academicCalendarData =
      <RowAcademiccalendarModel>[].obs;

  final Rx<AssessmentPageSchedule> assessmentschedulePage =
      AssessmentPageSchedule(assessmentModel: [], courseCode: []).obs;

  final Rx<ExamPageSchedule> examPageSchedule = ExamPageSchedule(
    midExam: [],
    finalExam: [],
  ).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    final focusedDate = DateTime.now().obs;
    await Future.wait([
      fetchScheduleTopHeader(focusedDate.value),
      fetchClassSchedule(focusedDate.value),
      fetchAssessment(sortBy: 'incomplete'),
      fetchExamPageSchedule(),
    ]);

    isLoading.value = false;
  }

  // A: --------------------------------------------------------------------------Class Schedule Calander----------------------------------------------------------------------
  Future<SchedulePageTopHeader> fetchScheduleTopHeader(DateTime date) async {
    // final userModel = userController.user.value;
    final model = schedulePageTopHeader.value;
    // model.noClass = null;
    // final days = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];

    // String dayKey = days[date.weekday - 1];

    // if (userModel?.current_course?.isEmpty ?? true) {
    //   return model;
    // }
    try {
      SectionsuperModel? classScheduleData;

      List<String> tempList = [];

      // if (classSchedulePageSchedule.value.classSchedule.isEmpty) {
      //   //DepartmentModel noCLassData;

      //   // final fetchedData = await departmentController.fetchDepartmentData(
      //   //   getNoCalss: true,
      //   // );
      //  // noCLassData = fetchedData;

      //   // if (noCLassData.rowNoclassModel != null) {
      //   //   for (var i in noCLassData.rowNoclassModel!) {
      //   //     // Holiday Check
      //   //     if (DatetimeStyle.isDateInRange(date, i.startDate!, i.endDate!)) {
      //   //       classSchedulePageSchedule.value.noClass = NoclassModel(
      //   //         title: i.title!,
      //   //         startDate: i.startDate!,
      //   //         endDate: i.endDate!,
      //   //         type: i.type!,
      //   //       );

      //   //       classSchedulePageSchedule.refresh();
      //   //       return classSchedulePageSchedule.value;
      //   //     }
      //   //   }
      //   // }
      // }

      // 2. Simple Image Logic
      if (date.month <= 4) {
        model.image = ImageStyle.spring();
      } else if (date.month <= 8) {
        model.image = ImageStyle.summer();
      } else {
        model.image = ImageStyle.fall();
      }

      int lastDay = DateTime(date.year, date.month + 1, 0).day;

      // Generate list: [Jan 1, Jan 2, ... Jan 31]
      model.curentMonth = List.generate(lastDay, (index) {
        return DateTime(date.year, date.month, index + 1);
      });

      classScheduleData = await courseController.fetchSectionData(
        getClassSchedule: true,
      );
      // loadAlldata.allDataSection = classScheduleData;

      // model.classSchedule.clear();
      //bool shouldPopulateDays = model.days.isEmpty;

      if (classScheduleData.schedules != null) {
        for (var i in classScheduleData.schedules!) {
          // if (shouldPopulateDays) {
          //   model.days.add(i.rowClassscheduleModel.day);
          // }

          tempList.add(i.rowClassscheduleModel.day);
        }
        model.days.addAll(tempList.toSet().toList());

        // Sort days only once
        // if (shouldPopulateDays) {
        //   model.days.sort();
        // }
      }

      // print("Selected day: ${model.days}");

      return model;
    } catch (e) {
      errorSnackbar(title: "class Schedule Data Fetching Error", e: e);
      return model;
    }
  }

  // A: --------------------------------------------------------------------------Class Schedule Calander----------------------------------------------------------------------
  Future<ClassSchedulePageSchedule> fetchClassSchedule(DateTime date) async {
    final model = classSchedulePage.value;
    try {
      isLoadingClassSchdule.value = true;

      // 1. Reset the model for the new date to prevent leftover data
      model.noClass = null;
      model.classSchedule = [];

      // --- STEP 1: CHECK FOR HOLIDAYS ---
      final fetchedDataDep = await departmentController.fetchDepartmentData(
        getNoCalss: true,
      );
      bool isHolidayFound = false; // Our simple switch!

      if (fetchedDataDep.rowNoclassModel != null) {
        for (var i in fetchedDataDep.rowNoclassModel!) {
          // Safe check to prevent that Null Check Error you saw earlier!
          if (i.startDate != null && i.endDate != null) {
            if (DatetimeStyle.isDateInRange(date, i.startDate!, i.endDate!)) {
              // We found a holiday!
              model.noClass = NoclassModel(
                title: i.title ?? "Holiday",
                startDate: i.startDate!,
                endDate: i.endDate!,
                type: i.type ?? "No Class",
              );

              isHolidayFound = true; // Flip the switch
              break; // EXIT THE LOOP IMMEDIATELY! No need to check other dates.
            }
          }
        }
      }

      // --- STEP 2: FETCH CLASSES (ONLY IF NOT A HOLIDAY) ---
      // If we flipped the switch to true, we skip this entirely and just return the holiday.
      if (!isHolidayFound) {
        final fetchedData = await courseController.fetchSectionData(
          getClassSchedule: true,
        );

        if (fetchedData.schedules != null) {
          final days = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];
          String dayKey = days[date.weekday - 1];

          for (var tempca in fetchedData.schedules!) {
            if (tempca.rowClassscheduleModel.day == dayKey) {
              model.classSchedule.add(tempca); // Just use standard add()
            }
          }

          model.classSchedule.sort(
            (a, b) => a.rowClassscheduleModel.endTime.compareTo(
              b.rowClassscheduleModel.endTime,
            ),
          );
          // model.classSchedule.sort((a, b) {
          //   final aStart = a.rowClassscheduleModel.startTime;
          //   final bStart = b.rowClassscheduleModel.startTime;
          //   return aStart.compareTo(bStart);
          // });
        }
      }

      // --- STEP 3: FINISH AND RETURN ---
      classSchedulePage.refresh(); // Tell the UI to update
      isLoadingClassSchdule.value = false;
      return model;
    } catch (e) {
      errorSnackbar(title: "Class Schedule Data Fetching Error", e: e);
      isLoadingClassSchdule.value = false;
      return model;
    }
  }

  // B: --------------------------------------------------------------------------Academic Calendar----------------------------------------------------------------------
  Future<List<RowAcademiccalendarModel>> fetchAcademicCalendar() async {
    try {
      final fetchData = await departmentController.fetchDepartmentData(
        getAcademicCalendar: true,
      );

      academicCalendarData.clear();
      academicCalendarData.addAll(fetchData.academiccalendarModel ?? []);

      return academicCalendarData;
    } catch (e) {
      errorSnackbar(title: "Academic Calendar data Fetching Error", e: e);
      return [];
    }
  }

  // C: --------------------------------------------------------------------------Assessment----------------------------------------------------------------------
  Future<AssessmentPageSchedule> fetchAssessment({
    String sortBy = 'All',
  }) async {
    try {
      final Set<String> tempCourseCodes = {"All"};
      List<AssessmentModel> tempAssessmentList = [];

      SectionsuperModel assessmentData;

      final fetchedData = await courseController.fetchSectionData(
        getAssessment: true,
      );
      assessmentData = fetchedData;

      // 3. Process Data
      if (assessmentData.assessment != null) {
        final assessmentList = assessmentData.assessment!;
        final now = DateTime.now();

        // Normalize today to midnight for comparison
        final today = DateTime(now.year, now.month, now.day);

        for (var item in assessmentList) {
          // A. Always add the course code to the filter list (regardless of current filter)
          tempCourseCodes.add(item.rowCourseModel.code);

          // B. Date Logic
          final DateTime itemDate = item.rowAssessmentModel.startTime;
          final DateTime eventDay = DateTime(
            itemDate.year,
            itemDate.month,
            itemDate.day,
          );

          bool shouldAdd = false;

          // C. Filter Logic
          if (sortBy == "complete") {
            if (eventDay.isBefore(today)) {
              shouldAdd = true;
            }
          } else if (sortBy == "incomplete") {
            if (!eventDay.isBefore(today)) {
              shouldAdd = true;
            }
          } else if (sortBy == 'All') {
            shouldAdd = true;
          } else {
            if (item.rowCourseModel.code == sortBy) {
              shouldAdd = true;
            }
          }

          if (shouldAdd) {
            tempAssessmentList.add(item);
          }
        }
      }

      tempAssessmentList.sort((a, b) {
        if (sortBy == 'incomplete') {
          return a.rowAssessmentModel.startTime.compareTo(
            b.rowAssessmentModel.startTime,
          ); // Ascending
        } else {
          return b.rowAssessmentModel.startTime.compareTo(
            a.rowAssessmentModel.startTime,
          ); // Descending (Newest on top)
        }
      });

      List<String> finalCodes = tempCourseCodes.toList();
      finalCodes.add("complete");
      finalCodes.add("incomplete");

      assessmentschedulePage.update((val) {
        val?.courseCode.clear();
        val?.courseCode.addAll(finalCodes);
        val?.assessmentModel.clear();
        val?.assessmentModel.addAll(tempAssessmentList);
      });

      return assessmentschedulePage.value;
    } catch (e) {
      print("Error fetching Assessment: $e");
      return assessmentschedulePage.value;
    }
  }

  // D: ------------------------------------------------------------------------EXAM----------------------------------------------------------------------

  Future<ExamPageSchedule> fetchExamPageSchedule() async {
    try {
      SectionsuperModel assessmentData;

      final fetchedData = await courseController.fetchSectionData(
        getAssessment: true,
      );
      assessmentData = fetchedData;

      for (var i in assessmentData.assessment!) {
        if (i.rowAssessmentModel.assessment.toLowerCase() == 'mid') {
          examPageSchedule.value.midExam.add(i);
        } else if (i.rowAssessmentModel.assessment.toLowerCase() == 'final') {
          examPageSchedule.value.finalExam.add(i);
        }
      }

      final midR = examPageSchedule.value.midExam.reversed.toList();
      final finalR = examPageSchedule.value.finalExam.reversed.toList();
      examPageSchedule.value.midExam.clear();
      examPageSchedule.value.finalExam.clear();
      examPageSchedule.value.midExam.addAll(midR);
      examPageSchedule.value.finalExam.addAll(finalR);

      return examPageSchedule.value;
    } catch (e) {
      return examPageSchedule.value;
    }
  }
}
