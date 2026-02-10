import 'dart:core';

import 'package:academicpanel/controller/account/account_controller.dart';
import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/department/department_controller.dart';
import 'package:academicpanel/controller/masterController/load_allData.dart';
import 'package:academicpanel/controller/result/result_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/AccountSuperModel/row_installment_model.dart';

import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/departmentSuperModel/department_model.dart';
import 'package:academicpanel/model/departmentSuperModel/noClass_model.dart';
import 'package:academicpanel/model/pages/home_page_model.dart';
import 'package:academicpanel/model/resultSuperModel/result_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_cgpacr_model.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:academicpanel/theme/style/dateTime_style.dart';
import 'package:academicpanel/utility/error_snackbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController {
  final userController = Get.find<UserController>();
  final courseController = Get.find<CourseController>();
  final accountController = Get.find<AccountController>();
  final departmentController = Get.find<DepartmentController>();
  final resultController = Get.find<ResultController>();
  final FirebaseDatapath firebaseDatapath = FirebaseDatapath();
  final loadAlldata = Get.find<LoadAlldata>();

  HomeTodayClassSchedule todayClassScheduleListHome = HomeTodayClassSchedule();

  final List<AnnouncementModel> announcementtHome = [];
  final List<AssessmentModel> assessmentHome = [];

  // ------------------------------------------------------------------------------MAIN HOME CONTROLLER----------------------------------------------------------------------
  Future<HomePageModel> mainHomeController() async {
    final userModel = userController.user.value;
    try {
      return HomePageModel(
        homeTopHeaderModel: await fetchHomePageHeader(userModel!),
        homeTodayClassSchedule: await todayClassSchedule(userModel),

        homeAccountInfoModel: await fetchAccountInfo(userModel),
        homeRowCgpaModel: await fetchCGPAinfo(),
        homeAnouncement: await fetchAllAnnouncements(),
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
        homeRowCgpaModel: RowCgpaCrModel(
          comment: '',
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
      final now = DateTime.now();

      String getFormattedDate() {
        return DateFormat('EEEE MMMM d').format(now);
      }

      // 3. Return Model
      return HomeTopHeaderModel(
        lastName: userModel.lastName,
        image: userModel.image,
        date: getFormattedDate(),
        semester: DatetimeStyle.getSemester(),
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
  Future<HomeTodayClassSchedule> todayClassSchedule(UserModel userModel) async {
    if (userModel.current_course == null || userModel.current_course!.isEmpty) {
      return todayClassScheduleListHome;
    }
    try {
      List<ClassscheduleModel> tempClassschedule = [];

      todayClassScheduleListHome.listClassScheduleModel ??= [];

      if (todayClassScheduleListHome.listClassScheduleModel!.isEmpty) {
        DepartmentModel noCLassData;

        final fetchedDataDep = await departmentController.fetchDepartmentData(
          getNoCalss: true,
        );
        noCLassData = fetchedDataDep;

        final now = DateTime.now();

        if (noCLassData.rowNoclassModel != null) {
          for (var i in noCLassData.rowNoclassModel!) {
            // Holiday Check
            if (DatetimeStyle.isDateInRange(now, i.startDate!, i.endDate!)) {
              todayClassScheduleListHome.noclassModel = NoclassModel(
                title: i.title!,
                startDate: i.startDate!,
                endDate: i.endDate!,
                type: i.type!,
              );
              todayClassScheduleListHome.listClassScheduleModel = [];
              return todayClassScheduleListHome;
            }
          }
        }

        SectionsuperModel classScheduleData;

        final fetchedData = await courseController.fetchSectionData(
          getClassSchedule: true,
        );
        classScheduleData = fetchedData;
        if (classScheduleData.schedules != null) {
          tempClassschedule = classScheduleData.schedules!;
        }
      }

      final now = DateTime.now();
      final days = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];
      String dayKey = days[now.weekday - 1];

      for (var tempca in tempClassschedule) {
        todayClassScheduleListHome.listClassScheduleModel?.addIf(
          tempca.rowClassscheduleModel.day == dayKey,
          tempca,
        );
      }

      todayClassScheduleListHome.listClassScheduleModel!.sort((a, b) {
        final aStart = a.rowClassscheduleModel.startTime;
        final bStart = b.rowClassscheduleModel.startTime;
        return aStart.compareTo(bStart);
      });

      final currentMinutes = (now.hour * 60) + now.minute;

      todayClassScheduleListHome.listClassScheduleModel?.removeWhere((
        classItem,
      ) {
        final parts = classItem.rowClassscheduleModel.endTime.split(':');
        final endHour = int.parse(parts[0]);
        final endMinute = int.parse(parts[1]);
        final classEndMinutes = (endHour * 60) + endMinute;
        return classEndMinutes < currentMinutes;
      });

      // todayClassScheduleListHome.listClassScheduleModel?.removeWhere((
      //   classItem,
      // ) {
      //   if (classItem.rowClassscheduleModel.endTime.isEmpty) return false;

      //   final parts = classItem.rowClassscheduleModel.endTime.split(':');
      //   if (parts.length != 2) return false;

      //   final endHour = int.parse(parts[0]);
      //   final endMinute = int.parse(parts[1]);
      //   final classEndMinutes = (endHour * 60) + endMinute;

      //   return classEndMinutes < currentMinutes;
      // });

      return todayClassScheduleListHome;
    } catch (e) {
      print(e);
      errorSnackbar(title: "classSchedule error", e: e);
      return todayClassScheduleListHome;
    }
  }

  // C: ----------------------------------------------------------------------------AccountInfo----------------------------------------------------------------------------------
  Future<HomeAccountModel> fetchAccountInfo(UserModel userModel) async {
    try {
      final fetchAccountData = await accountController.fetchAccountData();

      if (fetchAccountData.rowAcSatementModelList.isEmpty) {
        return HomeAccountModel(
          totalDue: 0,
          totalPaid: 0,
          paidPercentage: 0,
          upcomingInstallment: null,
          balance: fetchAccountData.rowAccountextModel.balance.toDouble(),
        );
      } else {
        double ac_statementTotal = 0;
        double paidTotal = 0;
        double totalFine = 0;

        // Calculate Totals
        for (var i in fetchAccountData.rowAcSatementModelList) {
          ac_statementTotal += i.amount;
        }
        for (var i in fetchAccountData.rowPaymentModelList) {
          paidTotal += i.amount;
        }
        // FIX 2: Add to 'totalFine', not 'paidTotal'
        for (var i in fetchAccountData.rowFineModelList) {
          totalFine += i.amount;
        }

        // 1. Calculate Total Fee needed after Waiver
        final double totalFeeAfterWaiver =
            ac_statementTotal -
            (ac_statementTotal *
                (fetchAccountData.rowAccountextModel.waiver / 100));

        // 2. Calculate Real Tuition Payment (Money paid - Money lost to fines + Previous Balance)
        // Note: This assumes 'balance' is positive for overpayment.
        // If balance is negative (due), subtract it.
        final double netPaidForTuition =
            paidTotal -
            totalFine +
            (fetchAccountData.rowAccountextModel.balance);

        // --- INSTALLMENT CHECK ---
        RowInstallmentModel? urgentInstallment;

        // FIX 3: Check if list is NOT empty before accessing .first
        if (fetchAccountData.rowInstallmentModelList.isNotEmpty) {
          // Create a copy so we don't mess up the original list
          final instList = List.from(fetchAccountData.rowInstallmentModelList);
          final now = DateTime.now();

          // FIX 4: Compare full Dates, not just 'day'
          // Remove deadlines that are essentially in the past (yesterday or before)
          instList.removeWhere((element) => element.deadline.isBefore(now));

          // Sort just in case they aren't in order
          instList.sort((a, b) => a.deadline.compareTo(b.deadline));

          if (instList.isNotEmpty) {
            final firstInst = instList.first;
            final diffDays = firstInst.deadline.difference(now).inDays;

            // If deadline is within 14 days
            if (diffDays <= 14 && diffDays >= -1) {
              // >= -1 handles "today" logic nicely

              // Calculate how much TOTAL needs to be paid by this date (e.g., 50% of total fee)
              final double targetAmount =
                  totalFeeAfterWaiver * (firstInst.amountPercentage / 100);

              // If we haven't reached that target yet
              if (netPaidForTuition < targetAmount) {
                final double amountLeftToPay = targetAmount - netPaidForTuition;

                urgentInstallment = RowInstallmentModel(
                  fine: firstInst.fine.toDouble(),
                  deadline: firstInst.deadline,
                  // Warning: You are storing an AMOUNT in a field named 'amountPercentage'.
                  // Ensure your UI knows this is $$$ not %.
                  amountPercentage: firstInst.amountPercentage,
                  code: firstInst.code,
                  amount: amountLeftToPay,
                );
              }
            }
          }
        }

        // Safe Percentage Calculation
        double percent = 0.0;
        if (totalFeeAfterWaiver > 0) {
          percent = (netPaidForTuition / totalFeeAfterWaiver).clamp(0.0, 1.0);
        }

        return HomeAccountModel(
          totalDue: totalFeeAfterWaiver, // Shows Total Billed Amount
          totalPaid: netPaidForTuition, // Shows Effective Amount Paid
          paidPercentage: percent,
          upcomingInstallment: urgentInstallment,
          balance: fetchAccountData.rowAccountextModel.balance.toDouble(),
        );
      }
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
  Future<RowCgpaCrModel> fetchCGPAinfo() async {
    try {
      ResultModel resultModel;

      if (loadAlldata.allDataResult?.rowCgpaCrModel == null) {
        final fetchedData = await resultController.fetchResultData(
          getCGPA: true,
        );
        resultModel = fetchedData;
      } else {
        resultModel = loadAlldata.allDataResult!;
      }

      return resultModel.rowCgpaCrModel!;
    } catch (e) {
      return RowCgpaCrModel(
        comment: '',
        credit_completed: 0,
        target_credit: 0,
        credit_enrolled: 0,
        pervious_cgpa: 0,
        current_cgpa: 0,
      );
    }
  }

  // e: ----------------------------------------------------------------------------Announcemnt----------------------------------------------------------------------------------

  Future<List<AnnouncementModel>> fetchAllAnnouncements() async {
    try {
      SectionsuperModel announcementData;

      if (loadAlldata.allDataSection!.announcements!.isEmpty) {
        final fetchedData = await courseController.fetchSectionData(
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
      assessmentHome.clear();

      SectionsuperModel assessmentData;

      if (loadAlldata.allDataSection!.assessment!.isEmpty) {
        final fetchedData = await courseController.fetchSectionData(
          getAssessment: true,
        );
        assessmentData = fetchedData;
      } else {
        assessmentData = loadAlldata.allDataSection!;
      }

      // print(
      //   "this is the assment list----------------------: ${assessmentData.announcements}",
      // );

      if (assessmentData.assessment != null) {
        final assessmenttList = assessmentData.assessment!;
        for (var item in assessmenttList) {
          if (item.rowAssessmentModel.startTime.isAfter(DateTime.now())) {
            assessmentHome.add(item);
          }
          // if (assessmentHome.length >= 4) break;
        }
      }

      final finalAssessmentHome = assessmentHome.reversed.take(4).toList();

      return finalAssessmentHome;
    } catch (e) {
      errorSnackbar(title: "Error fetching Assment", e: e);
      return [];
    }
  }
}
