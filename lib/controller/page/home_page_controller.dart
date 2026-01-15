import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/masterController/load_allData.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/Account/home_account_model.dart';
import 'package:academicpanel/model/Account/row_account_model.dart';
import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/pages/home_page_model.dart';
import 'package:academicpanel/model/result/row_cgpa_model.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:get/get.dart';
import 'package:academicpanel/utility/error_widget/error_snackBar.dart';

import 'package:intl/intl.dart';

class HomePageController extends GetxController {
  final userController = Get.find<UserController>();
  final CourseController courseController = Get.put(CourseController());
  final FirebaseDatapath firebaseDatapath = FirebaseDatapath();
  final loadAlldata = Get.find<LoadAlldata>();
  List<ClassscheduleModel> todayClassScheduleListHome = [];
  List<AnnouncementModel> announcementtHome = [];
  List<AssessmentModel> assessmentHome = [];

  // ------------------------------------------------------------------------------MAIN HOME CONTROLLER----------------------------------------------------------------------
  Future<HomePageModel> mainHomeController() async {
    final userModel = userController.user.value;
    try {
      return HomePageModel(
        homeTopHeaderModel: await fetchHomePageHeader(userModel!),
        homeTodayClassSchedule: await todayClassSchedule(userModel),

        homeAccountInfoModel: await fetchAccountInfo(userModel),
        homeRowCgpaModel: await fetchCGPAinfo(
          userModel.id,
          userModel.department,
        ),
        homeAnouncement: await fetchAllAnnouncements(userModel),
        homeAssessment: await fetchAssment(userModel),
      );
    } catch (e) {
      errorSnackbar(title: "Error", e: e);
      return HomePageModel(
        homeTopHeaderModel: HomeTopHeaderModel(
          lastName: '',
          image: '',
          date: '',
          semester: '',
        ),

        homeTodayClassSchedule: todayClassScheduleListHome,
        homeAnouncement: [],
        homeAccountInfoModel: HomeAccountModel(
          totalDue: 0,
          totalPaid: 0,
          paidPercentage: 0,
          balance: 0,
        ),
        homeRowCgpaModel: RowCgpaModel(
          credit_completed: 0,
          target_credit: 0,
          credit_enrolled: 0,
          pervious_cgpa: 0,
          current_cgpa: 0,
        ),
        homeAssessment: [],
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
      return todayClassScheduleListHome;
    }

    try {
      List<ClassscheduleModel> tempClassschedule = [];

      if (todayClassScheduleListHome.isEmpty) {
        SectionsuperModel classScheduleData;

        if (loadAlldata.allDataSection!.schedules!.isEmpty) {
          final fetchedData = await courseController.fetchSectionData(
            userModel: userModel,
            getClassSchedule: true,
          );
          classScheduleData = fetchedData;
        } else {
          classScheduleData = loadAlldata.allDataSection!;
        }

        if (classScheduleData.schedules != null) {
          tempClassschedule = classScheduleData.schedules!;
        }
      }

      final now = DateTime.now();
      final days = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];
      String dayKey = days[now.weekday - 1];

      for (var tempca in tempClassschedule) {
        todayClassScheduleListHome.addIf(tempca.day == dayKey, tempca);
      }

      final currentMinutes = (now.hour * 60) + now.minute;

      todayClassScheduleListHome.removeWhere((classItem) {
        final parts = classItem.endTime.split(':');
        final endHour = int.parse(parts[0]);
        final endMinute = int.parse(parts[1]);
        final classEndMinutes = (endHour * 60) + endMinute;
        return classEndMinutes < currentMinutes;
      });

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

  // C: ----------------------------------------------------------------------------AccountInfo----------------------------------------------------------------------------------
  Future<HomeAccountModel> fetchAccountInfo(UserModel userModel) async {
    try {
      final department = userModel.department;
      final semester = userModel.current_semester;

      // 1. Reference to Parent (Semester Rules)
      final accountDocRef = firebaseDatapath.accountData(department, semester!);
      // print("Account Doc Ref: ${accountDocRef.path}");

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
      final studentAccountRawData = RowAccountModel.fromMap(
        studentSnapshot.data()!,
      );

      // --- MATH SECTION ---

      print(
        "this is ac totat: ${studentAccountRawData.ac_statementTotal} and paid total ${studentAccountRawData.paidTotal}",
      );

      final double dueWithWaver =
          studentAccountRawData.ac_statementTotal -
          (studentAccountRawData.ac_statementTotal *
              (studentAccountRawData.waver_ / 100));

      final double netPaidForTuition =
          studentAccountRawData.paidTotal -
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

  // d: ----------------------------------------------------------------------------CGPA----------------------------------------------------------------------------------
  Future<RowCgpaModel> fetchCGPAinfo(String id, String department) async {
    try {
      final cgpaDocRef = await firebaseDatapath.cgpaData(department, id).get();

      final dataMap = cgpaDocRef.data();
      if (dataMap != null) {
        return RowCgpaModel.fromMap(dataMap);
      } else {
        return RowCgpaModel(
          credit_completed: 0,
          target_credit: 0,
          credit_enrolled: 0,
          pervious_cgpa: 0,
          current_cgpa: 0,
        );
      }
    } catch (e) {
      return RowCgpaModel(
        credit_completed: 0,
        target_credit: 0,
        credit_enrolled: 0,
        pervious_cgpa: 0,
        current_cgpa: 0,
      );
    }
  }

  // e: ----------------------------------------------------------------------------Announcemnt----------------------------------------------------------------------------------

  Future<List<AnnouncementModel>> fetchAllAnnouncements(
    UserModel userModel,
  ) async {
    try {
      SectionsuperModel announcementData;

      if (loadAlldata.allDataSection!.announcements!.isEmpty) {
        final fetchedData = await courseController.fetchSectionData(
          userModel: userModel,
          getAnnouncement: true,
        );
        announcementData = fetchedData;
      } else {
        announcementData = loadAlldata.allDataSection!;
      }

      if (announcementData.announcements != null) {
        final announcementList = announcementData.announcements!;
        for (var item in announcementList) {
          if (announcementtHome.length >= 4) break;
          announcementtHome.add(item);
        }
      }

      return announcementtHome;
    } catch (e) {
      errorSnackbar(title: "Error fetching Announcement", e: e);
      return [];
    }
  }
  // f: ----------------------------------------------------------------------------Assessment----------------------------------------------------------------------------------

  Future<List<AssessmentModel>> fetchAssment(UserModel userModel) async {
    try {
      SectionsuperModel assessmentData;

      if (loadAlldata.allDataSection!.assessment!.isEmpty) {
        final fetchedData = await courseController.fetchSectionData(
          userModel: userModel,
          getAssessment: true,
        );
        assessmentData = fetchedData;
      } else {
        assessmentData = loadAlldata.allDataSection!;
      }

      if (assessmentData.assessment != null) {
        final assessmenttList = assessmentData.assessment!;
        for (var item in assessmenttList) {
          if (assessmentHome.length >= 4) break;
          assessmentHome.add(item);
        }
      }

      return assessmentHome;
    } catch (e) {
      errorSnackbar(title: "Error fetching Assment", e: e);
      return [];
    }
  }
}
