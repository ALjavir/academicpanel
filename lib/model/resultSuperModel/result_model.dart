import 'package:academicpanel/model/resultSuperModel/row_resultBase_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_prev_result.dart';

class ResultModel {
  final RowResultbaseModel? rowResultbaseModel;
  final List<RowPrevResult>? rowPrevResult;
  final List<dynamic>? listPrevSem;

  ResultModel({this.rowResultbaseModel, this.rowPrevResult, this.listPrevSem});
}
