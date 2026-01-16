import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/departmentSuperModel/department_model.dart';
import 'package:academicpanel/model/departmentSuperModel/row_academicCalendar_model.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:academicpanel/utility/error_widget/error_snackbar.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class DepartmentController extends GetxController {
  final userController = Get.find<UserController>();
  final firebaseDatapath = Get.find<FirebaseDatapath>();

  final List<RowAcademiccalendarModel> academiccalendarModelData = [];

  Future<DepartmentModel> fetchDepartmentData({
    bool getAcademicCalendar = false,
  }) async {
    final userModel = userController.user.value;
    final departmentRef = firebaseDatapath.departmentData(
      userModel!.department,
    );
    try {
      final result = await departmentRef.get();
      final departmentResultData = result.data() ?? {};
      if (getAcademicCalendar) {
        final List<dynamic> calendarList =
            departmentResultData['academic_calendar'] ?? [];

        for (var item in calendarList) {
          academiccalendarModelData.add(
            RowAcademiccalendarModel.fromMap(item as Map<String, dynamic>),
          );
        }
      }

      return DepartmentModel(academiccalendarModel: academiccalendarModelData);
    } catch (e) {
      print(e);
      errorSnackbar(title: "Department Data Fetching Error", e: e);
      return DepartmentModel(academiccalendarModel: academiccalendarModelData);
    }
  }
}
