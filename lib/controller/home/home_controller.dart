import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/home/home_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:academicpanel/utility/error_widget/error_snackBar.dart';

class HomeController extends GetxController {
  final userController = Get.find<UserController>();
  Future<HomeTopHeaderModel?> fetchHomePageHeader() async {
    final userModel = userController.user.value;
    try {
      // Map department codes to full names
      String department = userModel!.department.toLowerCase().trim();
      switch (department) {
        case 'cse':
          department = 'Computer Science and Engineering';
          break;
        case 'eee':
          department = 'Electrical and Electronic Engineering';
        case 'bba':
          department = 'Bachelor of Business Administration';
          break;
        case 'eng':
          department = 'Department of English';
          break;
        default:
          department = userModel.department;
      }

      // show current dat
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('EEEE MMMM d').format(now);

      // Determine current semester
      String semester = getSemesterStyle(now);

      return HomeTopHeaderModel(
        lastName: userModel.lastName,
        department: department,
        id: userModel.id,
        dateTime: formattedDate,
        currentSmester: semester,
      );
    } catch (e) {
      errorSnackbar(title: "Error", e: e);

      return HomeTopHeaderModel(
        lastName: '',
        department: '',
        id: '',
        dateTime: '',
        currentSmester: '',
      );
    }
  }

  String getSemesterStyle(DateTime date) {
    int day = date.day;
    int month = date.month;
    int year = date.year;

    // "2nd week" usually implies the 8th day of the month or later.
    // We use 8 as the cutoff.
    int cutoffDay = 8;

    String season;
    int semesterYear = year;

    // LOGIC: Check in reverse order (Fall -> Summer -> Spring)

    // 1. Check if it is Fall (Starts Sept 2nd week)
    // If Month is AFTER Sept, OR it is Sept and day is >= 8th
    if (month > 9 || (month == 9 && day >= cutoffDay)) {
      season = "Fall";
    }
    // 2. Check if it is Summer (Starts May 2nd week)
    // If Month is AFTER May (but before Fall caught it), OR it is May and day >= 8th
    else if (month > 5 || (month == 5 && day >= cutoffDay)) {
      season = "Summer";
    }
    // 3. Check if it is Spring (Starts Jan 2nd week)
    // If Month is AFTER Jan, OR it is Jan and day >= 8th
    else if (month > 1 || (month == 1 && day >= cutoffDay)) {
      season = "Spring";
    }
    // 4. Handle the "Gap" (Jan 1st - Jan 7th)
    // If we are here, it is Jan 1st to Jan 7th.
    // Technically, this is still part of the previous year's Fall semester.
    else {
      season = "Fall";
      semesterYear = year - 1; // It belongs to the previous year cycle
    }

    // Format the year to short style (e.g., 2025 -> 25)
    String shortYear = semesterYear.toString().substring(2);

    return "$season-$shortYear";
  }
}
