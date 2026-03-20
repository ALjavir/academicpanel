import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';
import 'package:academicpanel/model/departmentSuperModel/department_model.dart';
import 'package:academicpanel/model/Announcement/row_announcement_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_departmentBaseData_model.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:academicpanel/utility/error_snackbar.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class DepartmentController extends GetxController {
  final userController = Get.find<UserController>();
  final firebaseDatapath = Get.find<FirebaseDatapath>();

  final List<RowAcademiccalendarModel> academiccalendarModelData = [];
  final List<AnnouncementModel> announcementModel = [];

  Future<DepartmentModel> fetchDepartmentData({
    bool getAcademicCalendar = false,
    bool getAnnouncement = false,
    bool getBaseData = false,
  }) async {
    final userModel = userController.user.value;
    final departmentRef = firebaseDatapath.departmentData(
      userModel!.department,
    );
    try {
      final result = await departmentRef.get();
      final resultData = result.data();
      final baseData = await RowDepartmenBaseModel.fromMap(resultData!);
      String current_sem = baseData.currentSem;

      //print("this is the testing of Base data whatsApp: ${baseData.whatsApp}");
      if (current_sem != "TBA" || current_sem != "" || current_sem.isNotEmpty) {
        try {
          final resultCurrentSem = await departmentRef
              .collection("semester")
              .doc(current_sem)
              .get();

          final departmentResultData = resultCurrentSem.data() ?? {};
          if (getAcademicCalendar) {
            final List<dynamic> calendarList =
                departmentResultData['academic_calendar'] ?? [];

            for (var item in calendarList) {
              academiccalendarModelData.add(
                RowAcademiccalendarModel.fromJson(item as Map<String, dynamic>),
              );
            }
          }
          if (getAnnouncement) {
            final whatsApp = baseData.whatsApp;

            final List<dynamic> announcementData =
                departmentResultData['announcements'] ?? [];

            for (var item in announcementData) {
              final data = RowAnnouncementModel.fromMap(
                item as Map<String, dynamic>,
              );

              announcementModel.add(
                AnnouncementModel(
                  rowCourseModel: RowCourseModel(
                    code: "N/A",
                    name: "Dept of CSE",
                    credit: 0,
                  ),
                  rowAnnouncementModel: data,
                  whatsApp: whatsApp,
                ),

                //RowAnnouncementModel.fromMap(item as Map<String, dynamic>),
              );
            }
            // foundAnnouncements = rawList.docs.map((item) {
            //   final data = item.data();
            //   //  final map = item as Map<String, dynamic>;
            //   final rowAnnouncement = RowAnnouncementModel.fromMap(data);
            //   // print("This is the rowAnnaounment: ${rowAnnouncement.message}");
            //   return AnnouncementModel(
            //     rowAnnouncementModel: rowAnnouncement,
            //     rowCourseModel: rowCourse,
            //     whatsApp: whatsApp,
            //   );
            // }).toList();

            announcementModel.sort(
              (a, b) => b.rowAnnouncementModel.createdAt.compareTo(
                a.rowAnnouncementModel.createdAt,
              ),
            );
          }
        } catch (e) {
          print(e);
          errorSnackbar(title: "Error->DeptCont", e: e);
        }
      }

      return DepartmentModel(
        academiccalendarModel: academiccalendarModelData,
        announcementModel: announcementModel,
        departmenBaseModel: baseData,
      );
    } catch (e) {
      print(e);
      errorSnackbar(title: "Department Data Fetching Error", e: e);
      return DepartmentModel(
        academiccalendarModel: academiccalendarModelData,
        departmenBaseModel: RowDepartmenBaseModel(whatsApp: '', currentSem: ''),
      );
    }
  }
}
