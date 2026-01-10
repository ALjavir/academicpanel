import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/Account/home_account_model.dart';
import 'package:academicpanel/model/Account/row_account_model.dart';
import 'package:academicpanel/model/global/anouncement.dart';
import 'package:academicpanel/model/global/classSchedule_model.dart';
import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/model/rowInput/rowInput_model.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:academicpanel/network/save_data/firebase/home_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:academicpanel/utility/error_widget/error_snackBar.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final userController = Get.find<UserController>();
  final HomeData homeData = HomeData();
  List<ClassscheduleModel> todayClassScheduleListHome = [];
  List<Anouncement> anouncementListHome = [];

  // ------------------------------------------------------------------------------MAIN HOME CONTROLLER----------------------------------------------------------------------
  Future<HomeModel> mainHomeController() async {
    final userModel = userController.user.value;
    try {
      return HomeModel(
        homeTopHeaderModel: await fetchHomePageHeader(userModel!),
        homeTodayClassSchedule: await todayClassSchedule(userModel),
        homeAnouncement: [],
        homeAccountInfoModel: await fetchAccountInfo(userModel),
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
        homeAccountInfoModel: HomeAccountModel(
          totalDue: 0,
          totalPaid: 0,
          paidPercentage: 0,
          balance: 0,
        ),
      );
    }
  }

  // A: --------------------------------------------------------------------------HOME TOP HEADER----------------------------------------------------------------------
  Future<HomeTopHeaderModel> fetchHomePageHeader(UserModel userModel) async {
    try {
      // 1. Format Date: "Monday January 1"
      String getFormattedDate() {
        return DateFormat('EEEE MMMM d').format(DateTime.now());
      }

      String getSemester() {
        return userModel.current_semester!
            .split('-')
            .map((e) => e.trim())
            .join(' - ' + "20");
      }

      // 3. Return Model
      return HomeTopHeaderModel(
        lastName: userModel.lastName,
        image: userModel.image,
        date: getFormattedDate(),
        semester: getSemester(),
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

  // B.1: ------------------------------------------------------------------------TODAY CLASS SCHEDULE----------------------------------------------------------------------
  Future<List<ClassscheduleModel>> todayClassSchedule(
    UserModel userModel,
  ) async {
    if (userModel.current_course!.isEmpty) {
      // print("No courses enrolled --------------- ");
      return todayClassScheduleListHome;
    }
    try {
      if (todayClassScheduleListHome.isEmpty) {
        await fetchClassTimeInfo(userModel);
        print("call fetchClassTimeInfo --------------- ");
      }
      final now = TimeOfDay.now();
      // 1. Get current time in minutes (e.g., 13:30 = 810 minutes)
      final currentMinutes = (now.hour * 60) + now.minute;

      // 2. Remove past classes
      todayClassScheduleListHome.removeWhere((classItem) {
        final parts = classItem.endTime.split(':');
        final endHour = int.parse(parts[0]);
        final endMinute = int.parse(parts[1]);
        final classEndMinutes = (endHour * 60) + endMinute;
        return classEndMinutes < currentMinutes;
      });

      // 3. Sort by startTime
      todayClassScheduleListHome.sort((a, b) {
        final partsA = a.startTime.split(':');
        final startMinutesA =
            (int.parse(partsA[0]) * 60) + int.parse(partsA[1]);

        final partsB = b.startTime.split(':');
        final startMinutesB =
            (int.parse(partsB[0]) * 60) + int.parse(partsB[1]);

        return startMinutesA.compareTo(startMinutesB);
      });

      return todayClassScheduleListHome;
    } catch (e) {
      errorSnackbar(title: "classSchedule error", e: e);
      return [];
    }
  }

  //B.2: Fetch Class Time Info from Firestore-----------------------------------
  Future<List<ClassscheduleModel>> fetchClassTimeInfo(
    UserModel userModel,
  ) async {
    try {
      final department = userModel.department;
      final courses = userModel.current_course;

      // 2. Get the correct day key
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

      final courseFutures = courses!.entries.map((entry) async {
        String courseCode = entry.key;
        String section = entry.value;

        //  print("Fetching for course: $courseCode, section: $section");

        // Get Reference (No await needed now)
        final courseCollectionRef = homeData.courseData(department, courseCode);
        // print("Course Ref: ${courseCollectionRef.path}");

        // Fetch Info and Section in parallel
        final results = await Future.wait([
          courseCollectionRef.get(),
          courseCollectionRef.collection('section').doc(section).get(),
        ]);

        final infoSnapshot = results[0];
        final sectionSnapshot = results[1];
        // print(
        //   "Fetched snapshots for ${infoSnapshot.exists}, section ${sectionSnapshot.exists}",
        // );

        // Process Data
        // Part 3: Inside your loop
        if (infoSnapshot.exists && sectionSnapshot.exists) {
          final secData = sectionSnapshot.data()!;
          final scheduleMap = secData['schedule'] as Map<String, dynamic>?;

          if (scheduleMap != null && scheduleMap.containsKey(dayKey)) {
            final todaysDetails = scheduleMap[dayKey] as Map<String, dynamic>;

            // 1. Prepare Course Data
            final courseData = infoSnapshot.data() ?? {};

            // 2. Create ClassscheduleModel
            return ClassscheduleModel.fromJoinedData(
              courseInfo: courseData,
              sectionData: secData,
              daySchedule: todaysDetails,
              defaultCode: courseCode,
            );
          }
        }
        return null;
      });

      // 4. WAIT for all courses to finish loading
      final results = await Future.wait(courseFutures);

      // 5. Filter out nulls and add to the main list
      for (var result in results) {
        if (result != null) {
          todayClassScheduleListHome.add(result);
        }
      }

      return todayClassScheduleListHome;
    } catch (e) {
      print("Error fetching schedule: $e");
      errorSnackbar(title: "fetchClassTimeInfo error", e: e);
      return [];
    }
  }

  // C: ----------------------------------------------------------------------------AccountInfo----------------------------------------------------------------------------------
  Future<HomeAccountModel> fetchAccountInfo(UserModel userModel) async {
    try {
      final department = userModel.department;
      final semester = userModel.current_semester;

      // 1. Reference to Parent (Semester Rules)
      final accountDocRef = homeData.accountData(department, semester!);
      print("Account Doc Ref: ${accountDocRef.path}");

      // 2. Fetch Parent (Rules) and Child (Student Data)
      final results = await Future.wait([
        accountDocRef.get(),
        accountDocRef.collection('student_id').doc(userModel.id).get(),
      ]);

      // 3. Process Data
      final infoSnapshot = results[0];
      final studentSnapshot = results[1];

      if (!studentSnapshot.exists) {
        return HomeAccountModel(
          totalDue: 0,
          totalPaid: 0,
          paidPercentage: 0,
          upcomingInstallment: null,
          balance: studentSnapshot.data()?['balance'] ?? 0,
        );
      }

      final infoData = infoSnapshot.exists ? infoSnapshot.data() : {};
      final studentAccountRawData = StudentAccountRawData.fromMap(
        studentSnapshot.data()!,
      );

      // --- MATH SECTION ---

      final double dueWithWaver =
          studentAccountRawData.due -
          (studentAccountRawData.due * (studentAccountRawData.waver_ / 100));

      final double netPaidForTuition =
          studentAccountRawData.paid -
          studentAccountRawData.totalFine +
          (studentAccountRawData.balance);

      // --- INSTALLMENT CHECK ---
      InstallmentModel? urgentInstallment;

      // Fetch installments from Parent Document
      // ... inside your function ...

      final installmentsMap = infoData?['installment'] as Map<String, dynamic>?;

      if (installmentsMap != null) {
        final now = DateTime.now();

        for (var key in installmentsMap.keys) {
          // 1. Create Model (Handles Timestamp conversion internally)
          final instData = RoeInstallmentModel.fromMap(
            installmentsMap[key] as Map<String, dynamic>,
          );

          if (instData.deadline != null) {
            final diffDays = instData.deadline!.difference(now).inDays;

            if (diffDays <= 14) {
              final double targetAmount =
                  dueWithWaver * (instData.amount_ / 100);

              // 5. Do I owe money?
              if (netPaidForTuition < targetAmount) {
                // Calculate the gap (How much more I need to pay to reach 50%)
                double dueNow = targetAmount - netPaidForTuition;

                urgentInstallment = InstallmentModel(
                  title: "$key",

                  dueDate: DateFormat('d MMMM').format(instData.deadline!),
                  fine: instData.fine.toDouble(),
                  amount: dueNow.toDouble(),
                );

                break;
              }
            }
          }
        }
      }

      // --- RETURN SUMMARY ---
      // Remaining = Total I must pay - What I actually paid (net)
      double remaining = dueWithWaver - netPaidForTuition;

      return HomeAccountModel(
        totalDue: remaining < 0 ? 0 : remaining.toDouble(),

        totalPaid: netPaidForTuition.toDouble(),

        paidPercentage: (netPaidForTuition / dueWithWaver).clamp(0.0, 1.0),
        upcomingInstallment: urgentInstallment,
        balance: studentAccountRawData.balance.toDouble(),
      );
    } catch (e) {
      print("Error: $e");
      return HomeAccountModel(
        totalDue: 0,
        totalPaid: 0,
        paidPercentage: 0,
        upcomingInstallment: null,
        balance: 0,
      );
    }
  }
}
