import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/resultSuperModel/result_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_cgpacr_model.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ResultController extends GetxController {
  final firebaseDatapath = Get.put(FirebaseDatapath());
  final userController = Get.find<UserController>();

  Future<ResultModel> fetchResultData({bool getCGPA = false}) async {
    try {
      final userModel = userController.user.value;
      final studentId = userModel!.id;
      final department = userModel.department;

      final resultDocRef = await firebaseDatapath
          .resultData(department, studentId)
          .get();
      final resultData = resultDocRef.data();

      if (getCGPA) {
        if (resultData!.isNotEmpty) {
          return ResultModel(
            rowCgpaCrModel: RowCgpaCrModel.fromMap(resultData),
          );
        }
      }

      return ResultModel();
    } catch (e) {
      return ResultModel();
    }
  }
}
