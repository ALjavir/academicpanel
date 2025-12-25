import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/global/anouncement.dart';
import 'package:academicpanel/model/global/classSchedule_model.dart';
import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:academicpanel/utility/error_widget/error_snackBar.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final userController = Get.find<UserController>();
  List<ClassscheduleModel> todayClassScheduleListHome = [];
  List<Anouncement> anouncementListHome = [];

  Future<HomeModel> mainHomeController() async {
    final userModel = userController.user.value;
    try {
      return HomeModel(
        homeTopHeaderModel: await fetchHomePageHeader(userModel!),

        homeTodayClassSchedule: await todayClassSchedule(userModel),
        homeAnouncement: [],
      );
    } catch (e) {
      errorSnackbar(title: "Error", e: e);
      return HomeModel(
        homeTopHeaderModel: HomeTopHeaderModel(
          lastName: '',
          image: '',
          date: '',
          semester: '',
        ),

        homeTodayClassSchedule: todayClassScheduleListHome,
        homeAnouncement: anouncementListHome,
      );
    }
  }

  Future<HomeTopHeaderModel> fetchHomePageHeader(UserModel userModel) async {
    try {
      // QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(userModel.department).get();

      // 1. Get Date String: "Friday July 11"
      String getFormattedDate() {
        return DateFormat('EEEE MMMM d').format(DateTime.now());
      }

      // 2. Calculate Semester: "Summer-25"
      String getCurrentSemester() {
        final now = DateTime.now();
        final yearShort = now.year % 100; // Get last 2 digits (2025 -> 25)
        String season = "";
        if (now.month >= 1 && now.month <= 4) {
          season = "Spring";
        } else if (now.month >= 5 && now.month <= 8) {
          season = "Summer";
        } else {
          season = "Fall"; // Sept - Dec
        }

        return "$season - $yearShort";
      }

      return HomeTopHeaderModel(
        lastName: userModel.lastName,
        image: userModel.image,
        date: getFormattedDate(),
        semester: getCurrentSemester(),
      );
    } catch (e) {
      errorSnackbar(title: "Error", e: e);
      return HomeTopHeaderModel(
        lastName: '',
        image: '',
        date: '',
        semester: '',
      );
    }
  }

  Future<List<ClassscheduleModel>> todayClassSchedule(
    UserModel userModel,
  ) async {
    try {
      if (todayClassScheduleListHome.isEmpty) {
        await fetchClassTimeInfo(userModel);
      }
      final now = TimeOfDay.now();
      final currentMinutes = now.hour * 60 + now.minute;
      // print("$currentMinutes --------------- ");

      // 3. FILTER: Remove classes where startTime has passed
      // Alternative: Only remove if the class is FINISHED

      todayClassScheduleListHome.removeWhere((classItem) {
        final parts = classItem.endTime.split(':'); // Use endTime here
        final classEndMinutes = int.parse(parts[0]) * 60 + int.parse(parts[1]);
        return classEndMinutes < currentMinutes;
      });

      // 4. SORT: Order remaining classes from Earliest to Latest
      // Since "14:00" is lexicographically larger than "09:00", String comparison works!
      todayClassScheduleListHome.sort(
        (a, b) => a.startTime.compareTo(b.startTime),
      );

      return todayClassScheduleListHome;
    } catch (e) {
      errorSnackbar(title: "classSchedule error", e: e);
      return [];
    }
  }

  Future<List<ClassscheduleModel>> fetchClassTimeInfo(
    UserModel userModel,
  ) async {
    final db = FirebaseFirestore.instance;

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
        //   print("$courseCode --------------- $section");
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
        // print("$infoSnapshot --------------- $sectionSnapshot");
        // 5. Process Data if documents exist
        if (infoSnapshot.exists && sectionSnapshot.exists) {
          final secData = sectionSnapshot.data()!;
          // final Map<String, dynamic> days = secData['schedule'] ?? [];
          //print("$secData --------------- ");
          // Check if class exists today
          // 1. Safe Cast: Get the 'schedule' object as a Map
          final scheduleMap = secData['schedule'] as Map<String, dynamic>;

          // 2. Check if the schedule contains Today's Key (e.g., 'su')
          if (scheduleMap.containsKey(dayKey)) {
            // 3. Get the inner map for today (The one with room, start, end)
            final todaysDetails = scheduleMap[dayKey] as Map<String, dynamic>;
            //   print("$dayKey --------------- ");

            todayClassScheduleListHome.add(
              ClassscheduleModel(
                name: infoSnapshot.get('name') ?? '',
                code: infoSnapshot.get('code') ?? courseCode,
                // --- HERE IS THE FIX ---
                // Access values by their KEY NAMES, not index [0]
                // using .toString() ensures safety if 'room' is stored as a number (202 vs "202")
                room: todaysDetails['room']?.toString() ?? 'TBA',
                startTime: todaysDetails['startTime'] ?? '00:00',
                endTime: todaysDetails['endTime'] ?? '00:00',
                instracter: secData['instracter'] ?? 'TBA',
              ),
            );
          }
        }
      }

      return todayClassScheduleListHome;
    } catch (e) {
      errorSnackbar(title: "Error", e: e);
      return todayClassScheduleListHome;
    }
  }
}
