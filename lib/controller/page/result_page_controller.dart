import 'package:academicpanel/controller/course/course_controller.dart';
import 'package:academicpanel/controller/masterController/load_allData.dart';
import 'package:academicpanel/controller/result/result_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';

import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/pages/result_Page_model.dart';
import 'package:academicpanel/model/resultSuperModel/result_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_assessment_mark.dart';
import 'package:academicpanel/model/resultSuperModel/row_cgpacr_model.dart';
import 'package:academicpanel/utility/error_snackbar.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class ResultPageController extends GetxController {
  final resultController = Get.find<ResultController>();
  final loadAlldata = Get.find<LoadAlldata>();
  final userController = Get.find<UserController>();
  final courseController = Get.find<CourseController>();
  RxBool isLoading = true.obs;

  final Rxn<RowCgpaCrModel> rowCgpaModelData = Rxn<RowCgpaCrModel>();

  final RxList<CurrentSemResultModel> listCurrentSemResultData =
      <CurrentSemResultModel>[].obs;
  final Rxn<PrevSemResultResultPage> PrevSemResultData =
      Rxn<PrevSemResultResultPage>();

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    await Future.wait([fetchCGPAinfo(), fetchListCurrentSemResult()]);

    isLoading.value = false;
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

      return rowCgpaModelData.value = resultModel.rowCgpaCrModel!;
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

  // b: ----------------------------------------------------------------------------Current Sem Result----------------------------------------------------------------------------------
  Future<List<CurrentSemResultModel>> fetchListCurrentSemResult() async {
    try {
      SectionsuperModel assessmentData;
      if (loadAlldata.allDataSection!.assessment!.isEmpty) {
        final fetchedData = await courseController.fetchSectionData(
          getAssessment: true,
        );
        assessmentData = fetchedData;
      } else {
        assessmentData = loadAlldata.allDataSection!;
      }

      Map<String, List<AssessmentModel>> groupedDataTemp = {};
      for (var item in assessmentData.assessment!) {
        groupedDataTemp
            .putIfAbsent(item.rowCourseModel.code, () => [])
            .add(item);
      }
      List<CurrentSemResultModel> groupedDataFinal = [];
      for (var courseAssessments in groupedDataTemp.values) {
        List<RowAssessmentMark> quizList = [];
        List<RowAssessmentMark> assignmentList = [];

        RowAssessmentMark midE = RowAssessmentMark(
          assessment: "",
          mark: 0,
          score: 0,
        );
        RowAssessmentMark finalE = RowAssessmentMark(
          assessment: "",
          mark: 0,
          score: 0,
        );
        RowAssessmentMark presentation = RowAssessmentMark(
          assessment: "",
          mark: 0,
          score: 0,
        );
        RowAssessmentMark viva = RowAssessmentMark(
          assessment: "",
          mark: 0,
          score: 0,
        );

        double totalMark = 0;
        for (var j in courseAssessments) {
          final rowssmerk = RowAssessmentMark(
            assessment: j.rowAssessmentModel.assessment,
            mark: j.rowAssessmentModel.mark,
            score: j.rowAssessmentModel.result,
          );

          if (j.rowAssessmentModel.result.toInt().toString() ==
              userController.user.value!.id) {
            totalMark += 0;
          } else {
            totalMark += j.rowAssessmentModel.result;
          }

          String type = j.rowAssessmentModel.assessment.toLowerCase();

          if (type.startsWith("q")) {
            quizList.add(rowssmerk);
          } else if (type.startsWith("a")) {
            assignmentList.add(rowssmerk);
          } else if (type.startsWith("m")) {
            midE = rowssmerk;
          } else if (type.startsWith("f")) {
            finalE = rowssmerk;
          } else if (type.startsWith("p")) {
            presentation = rowssmerk;
          } else if (type.startsWith("v")) {
            viva = rowssmerk;
          }
        }

        quizList.sort((a, b) => a.assessment.compareTo(b.assessment));
        assignmentList.sort((a, b) => a.assessment.compareTo(b.assessment));

        CurrentSemResultModel mainAssessmentModel = CurrentSemResultModel(
          quizList: quizList,
          assignmentList: assignmentList,
          presentation: presentation,
          viva: viva,
          midE: midE,
          finalE: finalE,
          totalMark: totalMark,
          grade: "grade",
          rowCourseModel: courseAssessments.first.rowCourseModel,
        );

        groupedDataFinal.add(mainAssessmentModel);
      }
      // for (var i in groupedDataFinal) {
      //   print("${i.rowCourseModel.code} - ${i.totalMark}}");
      // }

      return listCurrentSemResultData.value = groupedDataFinal;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  // c: ----------------------------------------------------------------------------Prev Sem Result----------------------------------------------------------------------------------

  Future<PrevSemResultResultPage> fetchPrevSemResultData(
    String semester,
  ) async {
    try {
      final resultModel = await resultController.fetchResultData(
        getPrevResult: true,
        semester: semester,
      );

      return PrevSemResultData.value = PrevSemResultResultPage(
        prevSemester: semester,
        listPrevSem: resultModel.listPrevSem!,
        rowPrevResultList: resultModel.rowPrevResult!,
      );
    } catch (e) {
      print("Error fetching previous semester result: $e");
      return PrevSemResultData.value = PrevSemResultResultPage(
        prevSemester: semester,
        listPrevSem: [],
        rowPrevResultList: [],
      );
    }
  }
}
