import 'dart:core';

import 'package:academicpanel/controller/account/account_controller.dart';
import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/department/department_controller.dart';
import 'package:academicpanel/controller/result/result_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/AccountSuperModel/row_installment_model.dart';

import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/departmentSuperModel/department_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:academicpanel/model/pages/home_page_model.dart';
import 'package:academicpanel/model/resultSuperModel/result_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_resultBase_model.dart';
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
  final firebaseDatapath = Get.find<FirebaseDatapath>();

  // final loadAlldata = Get.find<LoadAlldata>();

  HomeTodayClassSchedule todayClassScheduleListHome = HomeTodayClassSchedule();

  final List<AnnouncementModel> announcementtHome = [];
  final List<AssessmentModel> assessmentHome = [];
  late DepartmentModel deptModelData;
  // ------------------------------------------------------------------------------MAIN HOME CONTROLLER----------------------------------------------------------------------
  Future<HomePageModel> mainHomeController() async {
    final userModel = userController.user.value;
    try {
      return HomePageModel(
        homeTopHeaderModel: await fetchHomePageHeader(userModel!),
        homeTodayClassSchedule: await todayClassSchedule(userModel),

        homeAccountInfoModel: await fetchAccountInfo(userModel),
        rowResultbaseModel: await fetchCGPAinfo(),
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
          amountLeftToPay: 0,
        ),
        rowResultbaseModel: RowResultbaseModel(
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
      // List<RowAcademiccalendarModel> noClass = [];
      todayClassScheduleListHome.listClassScheduleModel ??= [];

      // Safely check if the list is either null OR empty
      if (todayClassScheduleListHome.listClassScheduleModel?.isEmpty ?? true) {
        final fetchedDataDep = await departmentController.fetchDepartmentData(
          getAcademicCalendar: true,
        );

        deptModelData = fetchedDataDep;
        final now = DateTime.now();

        // 1. Single Loop Processing
        final calendarModel = deptModelData.academiccalendarModel;

        if (calendarModel != null) {
          for (var event in calendarModel) {
            final type = event.type.toLowerCase();

            // 2. Check type AND date range at the exact same time
            if ((type == "holiday" || type == "exam") &&
                DatetimeStyle.isDateInRange(
                  now,
                  event.startDate,
                  event.endDate,
                )) {
              todayClassScheduleListHome.noclassModel =
                  RowAcademiccalendarModel(
                    title: event.title,
                    startDate: event.startDate,
                    endDate: event.endDate,
                    type: event.type,
                  );
              todayClassScheduleListHome.listClassScheduleModel = [];

              return todayClassScheduleListHome; // Exit early!
            }
          }
        }

        // 3. Clean variable declaration
        final classScheduleData = await courseController.fetchSectionData(
          getClassSchedule: true,
        );

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

      DateFormat format = DateFormat("h:mm a");
      todayClassScheduleListHome.listClassScheduleModel!.sort((a, b) {
        DateTime timeA = format.parse(a.rowClassscheduleModel.endTime);
        DateTime timeB = format.parse(b.rowClassscheduleModel.endTime);
        return timeA.compareTo(timeB);
      });

      final currentMinutes = (now.hour * 60) + now.minute;

      todayClassScheduleListHome.listClassScheduleModel?.removeWhere((
        classItem,
      ) {
        final parts = classItem.rowClassscheduleModel.endTime.split(':');

        final endHour = int.parse(parts[0]);
        final endMinute = int.parse(parts[1].split(" ")[0]);

        final classEndMinutes = (endHour * 60) + endMinute;
        return classEndMinutes < currentMinutes;
      });

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
          amountLeftToPay: 0,
        );
      } else {
        double ac_statementTotal = 0;
        double paidTotal = 0;
        double totalFine = 0;
        double amountLeftToPay = 0;

        for (var i in fetchAccountData.rowAcSatementModelList) {
          ac_statementTotal += i.amount;
        }
        for (var i in fetchAccountData.rowPaymentModelList) {
          paidTotal += i.amount;
        }

        for (var i in fetchAccountData.rowFineModelList) {
          if (i.target < i.paid) {
            totalFine += i.amount;
          }
        }

        // 1. Calculate Total Fee needed after Waiver
        final waiverAmount =
            ac_statementTotal *
            (fetchAccountData.rowAccountextModel.waiver / 100);
        final double totalFeeAfterWaiver =
            (ac_statementTotal + totalFine) -
            (waiverAmount + (fetchAccountData.rowAccountextModel.balance));

        //final double netPaidForTuition = paidTotal - totalFine;

        // --- INSTALLMENT CHECK ---
        RowInstallmentModel? urgentInstallment;

        if (fetchAccountData.rowInstallmentModelList.isNotEmpty) {
          final instList = List.from(fetchAccountData.rowInstallmentModelList);
          final now = DateTime.now();

          instList.removeWhere((element) => element.deadline.isBefore(now));

          instList.sort((a, b) => a.deadline.compareTo(b.deadline));

          if (instList.isNotEmpty) {
            final firstInst = instList.first;
            final diffDays = firstInst.deadline.difference(now).inDays;

            // If deadline is within 14 days
            if (diffDays <= 14 && diffDays >= 0) {
              final double targetAmount =
                  totalFeeAfterWaiver * (firstInst.amountPercentage / 100);

              if (paidTotal < targetAmount) {
                amountLeftToPay = targetAmount - paidTotal;

                urgentInstallment = RowInstallmentModel(
                  fine: firstInst.fine.toDouble(),
                  deadline: firstInst.deadline,

                  amountPercentage: firstInst.amountPercentage,
                  code: firstInst.code,
                  // amount: amountLeftToPay,
                );
              }
            }
          }
        }

        // Safe Percentage Calculation
        double percent = 0.0;
        if (totalFeeAfterWaiver > 0) {
          percent = (paidTotal / totalFeeAfterWaiver).clamp(0.0, 1.0);
        }

        return HomeAccountModel(
          totalDue: totalFeeAfterWaiver, // Shows Total Billed Amount
          totalPaid: paidTotal, // Shows Effective Amount Paid
          paidPercentage: percent,
          upcomingInstallment: urgentInstallment,
          balance: fetchAccountData.rowAccountextModel.balance.toDouble(),
          amountLeftToPay: amountLeftToPay,
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
        amountLeftToPay: 0,
      );
    }
  }

  // d: ----------------------------------------------------------------------------CGPA----------------------------------------------------------------------------------
  Future<RowResultbaseModel> fetchCGPAinfo() async {
    try {
      ResultModel resultModel;

      final fetchedData = await resultController.fetchResultData(getCGPA: true);
      resultModel = fetchedData;
      print(
        "this is another carzy shit:--------------------------------${resultModel}",
      );
      // print(
      //   "this is another carzy shit comment:--------------------------------${resultModel.rowResultbaseModel!.comment}",
      // );
      print(
        "this is another carzy shit credit_completed:--------------------------------${resultModel.rowResultbaseModel!.credit_completed}",
      );
      // print(
      //   "this is another carzy shit credit_enrolled:--------------------------------${resultModel.rowResultbaseModel!.credit_enrolled}",
      // );
      // print(
      //   "this is another carzy shit current_cgpa:--------------------------------${resultModel.rowResultbaseModel!.current_cgpa}",
      // );
      // print(
      //   "this is another carzy shit pervious_cgpa:--------------------------------${resultModel.rowResultbaseModel!.pervious_cgpa}",
      // );
      // print(
      //   "this is another carzy shit target_credit:--------------------------------${resultModel.rowResultbaseModel!.target_credit}",
      // );

      return resultModel.rowResultbaseModel!;
    } catch (e) {
      return RowResultbaseModel(
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
      List<AnnouncementModel> tempAnnouncementList = [];

      var departAnnouncementData = deptModelData.announcementModel ?? [];

      if (departAnnouncementData.isEmpty) {
        final fetchedDataDep = await departmentController.fetchDepartmentData(
          getAnnouncement: true,
        );
        deptModelData = fetchedDataDep;
        departAnnouncementData = deptModelData.announcementModel ?? [];
      }

      final courseModelData = await courseController.fetchSectionData(
        getAnnouncement: true,
      );
      final courseAnnouncements = courseModelData.announcements ?? [];

      tempAnnouncementList.addAll(courseAnnouncements.take(4));
      // for (var element in tempAnnouncementList) {
      //   // print(
      //   //   "announcment course:${DateFormat('MMM d, y').format(element.rowAnnouncementModel.createdAt)} - ${element.rowAnnouncementModel.createdAt.runtimeType}",
      //   // );
      // }

      int remainingSlots = 8 - tempAnnouncementList.length;
      tempAnnouncementList.addAll(departAnnouncementData.take(remainingSlots));
      // for (var element in tempAnnouncementList) {
      //   // print(
      //   //   "announcment dept:${DateFormat('MMM d, y').format(element.rowAnnouncementModel.createdAt)} - ${element.rowAnnouncementModel.createdAt.runtimeType}",
      //   // );
      // }

      tempAnnouncementList.sort(
        (a, b) => b.rowAnnouncementModel.createdAt.compareTo(
          a.rowAnnouncementModel.createdAt,
        ),
      );

      announcementtHome.clear();
      announcementtHome.addAll(tempAnnouncementList.take(4));

      return announcementtHome;
    } catch (e) {
      print("Error fetching announcements: $e");

      return announcementtHome;
    }
  }
  // f: ----------------------------------------------------------------------------Assessment----------------------------------------------------------------------------------

  Future<List<AssessmentModel>> fetchAssment(UserModel userModel) async {
    try {
      assessmentHome.clear();

      SectionsuperModel assessmentData;

      final fetchedData = await courseController.fetchSectionData(
        getAssessment: true,
      );
      assessmentData = fetchedData;

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
