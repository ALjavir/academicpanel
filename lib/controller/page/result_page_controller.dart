import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/masterController/load_allData.dart';
import 'package:academicpanel/controller/result/result_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/pages/result_Page_model.dart';
import 'package:academicpanel/model/resultSuperModel/result_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_cgpacr_model.dart';
import 'package:academicpanel/utility/error_snackbar.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class ResultPageController extends GetxController {
  final resultController = Get.find<ResultController>();
  final loadAlldata = Get.find<LoadAlldata>();
  final userController = Get.find<UserController>();
  final courseController = Get.find<CourseController>();

  late final RowCgpaCrModel rowCgpaModelData;
  final List<AssessmentResult> ListAssessmentResult = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchCGPAinfo();
    await fetchListAssessmentResult();
  }

  // a: ----------------------------------------------------------------------------CGPA----------------------------------------------------------------------------------
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

      return rowCgpaModelData = resultModel.rowCgpaCrModel!;
    } catch (e) {
      errorSnackbar(title: 'Error in Result', e: e);
      print(e);
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

  Future<List<AssessmentResult>> fetchListAssessmentResult() async {
    try {
      final Set<String> tempCourseCodes = {};
      List<List<AssessmentModel>> tempAssessmentList = [];
      //  List<List<AssessmentResult>> tempAssesmentResult = [];

      SectionsuperModel assessmentData;

      if (loadAlldata.allDataSection!.assessment!.isEmpty) {
        final fetchedData = await courseController.fetchSectionData(
          getAssessment: true,
        );
        assessmentData = fetchedData;
      } else {
        assessmentData = loadAlldata.allDataSection!;
      }

      Map<String, List<AssessmentModel>> groupedData = {};

      for (var item in assessmentData.assessment!) {
        // If the list for this code doesn't exist, create it. Then add the item.
        groupedData.putIfAbsent(item.rowCourseModel.code, () => []).add(item);
      }
      for (var i in groupedData.values) {
        print(i);
        for (var i in i) {
          print(i.rowAssessmentModel.assessment);
        }
      }

      // 2. Convert the Map values back to your List<List>

      return ListAssessmentResult;
    } catch (e) {
      return ListAssessmentResult;
    }
  }
}
