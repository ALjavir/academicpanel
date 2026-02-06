import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/resultSuperModel/result_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_cgpacr_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_prev_result.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ResultController extends GetxController {
  final firebaseDatapath = Get.put(FirebaseDatapath());
  final userController = Get.find<UserController>();

  Future<ResultModel> fetchResultData({
    bool getCGPA = false,
    bool getPrevResult = false,
    String semester = '',
  }) async {
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

      if (getPrevResult) {
        // print(
        //   "Fetching previous results for student ID: $studentId in department: $department",
        // );
        // print(
        //   "Fetched ${resultData!["prevSemResult"].runtimeType} results for $semester",
        // );
        final prevSemList = resultData!["prevSemResult"] as List<dynamic>?;

        if (semester.isEmpty) {
          if (prevSemList != null && prevSemList.isNotEmpty) {
            semester = prevSemList.last.toString();
          }
        }

        final List<RowPrevResult> prevResultList = [];

        if (semester.isNotEmpty) {
          try {
            final prevResultSnapshot = await firebaseDatapath
                .resultData(department, studentId)
                .collection(semester)
                .get();

            if (prevResultSnapshot.docs.isNotEmpty) {
              for (var doc in prevResultSnapshot.docs) {
                try {
                  final data = doc.data();
                  final rowPrevResult = RowPrevResult.fromMap(data);
                  prevResultList.add(rowPrevResult);
                } catch (e) {
                  print("Error parsing specific row in $semester: $e");
                }
              }
            }
          } catch (e) {
            print("Error fetching collection for $semester: $e");
          }
        }

        return ResultModel(
          listPrevSem: prevSemList,
          rowPrevResult: prevResultList,
        );
      }

      return ResultModel();
    } catch (e) {
      return ResultModel();
    }
  }
}
