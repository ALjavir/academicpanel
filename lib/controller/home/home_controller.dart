import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:academicpanel/utility/error_widget/error_snackBar.dart';

class HomeController extends GetxController {
  final userController = Get.find<UserController>();

  Future<HomeModel> mainHomeController() async {
    final userModel = userController.user.value;
    try {
      return HomeModel(
        homeTopHeaderModel: await fetchHomePageHeader(userModel!),
        todayClass: await fetchClassTime(userModel),
      );
    } catch (e) {
      errorSnackbar(title: "Error", e: e);
      return HomeModel(
        homeTopHeaderModel: HomeTopHeaderModel(lastName: '', image: ''),
        todayClass: TodayClass(),
      );
    }
  }

  Future<HomeTopHeaderModel> fetchHomePageHeader(UserModel userModel) async {
    try {
      // QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(userModel.department).get();

      return HomeTopHeaderModel(
        lastName: userModel.lastName,
        image: userModel.image,
      );
    } catch (e) {
      errorSnackbar(title: "Error", e: e);
      return HomeTopHeaderModel(lastName: '', image: '');
    }
  }

  //final classTimeList = <ClassTime>[];
  Future<TodayClass> fetchClassTime(UserModel userModel) async {
    print(
      "object--------------------------------------------------------------------",
    );
    final db = FirebaseFirestore.instance;
    List<ClassTime> todayClass = [];

    try {
      final depat = userModel.department;
      final courses =
          userModel.courses; // Map<String, String> -> {Code: Section}

      // 1. Get Today's Key (e.g., "su", "mo")
      // DateTime.weekday returns 1 (Mon) to 7 (Sun)
      final now = DateTime.now();
      String dayKey = '';
      switch (now.weekday) {
        case DateTime.sunday:
          dayKey = 'su';
          break;
        case DateTime.monday:
          dayKey = 'mo';
          break;
        case DateTime.tuesday:
          dayKey = 'tu';
          break;
        case DateTime.wednesday:
          dayKey = 'we';
          break;
        case DateTime.thursday:
          dayKey = 'th';
          break;
        case DateTime.friday:
          dayKey = 'fr';
          break;
        case DateTime.saturday:
          dayKey = 'sa';
          break;
      }

      // 2. Iterate through enrolled courses
      for (var entry in courses!.entries) {
        String courseCode = entry.key; // e.g., "CSE101"
        String section = entry.value; // e.g., "SEC1"
        print("$courseCode --------------- $section");
        // 3. Define references
        // Path: course -> {Department} -> {CourseCode} (Collection)
        final courseCollectionRef = db
            .collection('course')
            .doc(depat)
            .collection(courseCode);

        // 4. Fetch INFO and SECTION documents in parallel for speed
        final results = await Future.wait([
          courseCollectionRef.doc('INFO').get(),
          courseCollectionRef.doc(section).get(),
        ]);
        final infoSnapshot = results[0];
        final sectionSnapshot = results[1];
        print("$infoSnapshot --------------- $sectionSnapshot");
        // 5. Process Data if documents exist
        if (infoSnapshot.exists && sectionSnapshot.exists) {
          final secData = sectionSnapshot.data()!;
          final Map<String, dynamic> days = secData['schedule'] ?? [];
          print("$secData --------------- ");
          // Check if class exists today
          if (days.keys.contains(dayKey)) {
            final scheduleMap = secData['schedule'] as Map<String, dynamic>;
            print(
              "------------------------------------------------------------",
            );

            final todaysDetails = scheduleMap[dayKey];
            print(todaysDetails);
            todayClass.add(
              ClassTime(
                name: infoSnapshot.get('name') ?? '',
                code: infoSnapshot.get('code') ?? courseCode,
                time: todaysDetails[0] ?? "no",
                room: todaysDetails[1] ?? 'no',
                instracter: secData['instracter'] ?? 'Unknown',
              ),
            );
          }
        }
      }

      return TodayClass(classTime: todayClass);
    } catch (e) {
      errorSnackbar(title: "Error", e: e);
      return TodayClass(classTime: []);
    }
  }

  // String getSemesterStyle(DateTime date) {
  //   int day = date.day;
  //   int month = date.month;
  //   int year = date.year;
  //   int cutoffDay = 8;

  //   String season;
  //   int semesterYear = year;

  //   // LOGIC: Check in reverse order (Fall -> Summer -> Spring)

  //   // 1. Check if it is Fall (Starts Sept 2nd week)
  //   // If Month is AFTER Sept, OR it is Sept and day is >= 8th
  //   if (month > 9 || (month == 9 && day >= cutoffDay)) {
  //     season = "Fall";
  //   }
  //   // 2. Check if it is Summer (Starts May 2nd week)
  //   // If Month is AFTER May (but before Fall caught it), OR it is May and day >= 8th
  //   else if (month > 5 || (month == 5 && day >= cutoffDay)) {
  //     season = "Summer";
  //   }
  //   // 3. Check if it is Spring (Starts Jan 2nd week)
  //   // If Month is AFTER Jan, OR it is Jan and day >= 8th
  //   else if (month > 1 || (month == 1 && day >= cutoffDay)) {
  //     season = "Spring";
  //   }
  //   // 4. Handle the "Gap" (Jan 1st - Jan 7th)
  //   // If we are here, it is Jan 1st to Jan 7th.
  //   // Technically, this is still part of the previous year's Fall semester.
  //   else {
  //     season = "Fall";
  //     semesterYear = year - 1; // It belongs to the previous year cycle
  //   }

  //   // Format the year to short style (e.g., 2025 -> 25)
  //   String shortYear = semesterYear.toString().substring(2);

  //   return "$season-$shortYear";
  // }
}
