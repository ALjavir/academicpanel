import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/masterController/load_allData.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/pages/schedule_page_model.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class SchedulePageContoller extends GetxController {
  final userController = Get.find<UserController>();
  final loadAlldata = Get.find<LoadAlldata>();
  final courseController = Get.find<CourseController>();

  final Rx<ClassSchedulePageSchedule> classSchedulePageSchedule =
      ClassSchedulePageSchedule(days: [], classSchedule: []).obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch today's data immediately when app starts
    final focusedDate = DateTime.now().obs;
    final days = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];

    // Change this line:
    String dayKey = days[focusedDate.value.weekday - 1];
    fetchclassScheduleCalander(dayKey);
  }

  Future<ClassSchedulePageSchedule> fetchclassScheduleCalander(
    String day,
  ) async {
    final userModel = userController.user.value;
    final model = classSchedulePageSchedule.value;
    if (userModel?.current_course?.isEmpty ?? true) {
      return model;
    }
    try {
      SectionsuperModel? classScheduleData;
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

          if (i.day == day) {
            model.classSchedule.add(i);
          }
        }

        // Sort days only once
        if (shouldPopulateDays) {
          model.days.sort();
        }
      }

      print("Selected day: $day");
      print("Classes found: ${model.classSchedule.length}");

      classSchedulePageSchedule.refresh();
      return model;
    } catch (e) {
      print("Error: $e");
      return model;
    }
  }
}
