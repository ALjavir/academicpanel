import 'package:academicpanel/controller/masterController/load_allData.dart';
import 'package:academicpanel/controller/result/result_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/resultSuperModel/result_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_cgpa_model.dart';
import 'package:academicpanel/utility/error_snackbar.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class ResultPageController extends GetxController {
  final resultController = Get.find<ResultController>();
  final loadAlldata = Get.find<LoadAlldata>();
  final userController = Get.find<UserController>();

  late RowCgpaModel rowCgpaModelData;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchCGPAinfo();
  }

  // a: ----------------------------------------------------------------------------CGPA----------------------------------------------------------------------------------
  Future<RowCgpaModel> fetchCGPAinfo() async {
    try {
      ResultModel resultModel;
      if (loadAlldata.allDataResult?.rowCgpaModel == null ||
          loadAlldata.allDataResult!.rowCgpaModel == null) {
        final fetchedData = await resultController.fetchResultData(
          getCGPA: true,
        );
        resultModel = fetchedData;
      } else {
        resultModel = loadAlldata.allDataResult!;
      }

      return rowCgpaModelData = resultModel.rowCgpaModel!;
    } catch (e) {
      errorSnackbar(title: 'Error in Result', e: e);
      print(e);
      return RowCgpaModel(
        comment: '',
        credit_completed: 0,
        target_credit: 0,
        credit_enrolled: 0,
        pervious_cgpa: 0,
        current_cgpa: 0,
      );
    }
  }
}
