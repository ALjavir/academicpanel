import 'package:academicpanel/model/resultSuperModel/row_cgpacr_model.dart';
import 'package:academicpanel/model/resultSuperModel/row_prev_result.dart';

class ResultModel {
  final RowCgpaCrModel? rowCgpaCrModel;
  final List<RowPrevResult>? rowPrevResult;
  final List<dynamic>? listPrevSem;

  ResultModel({this.rowCgpaCrModel, this.rowPrevResult, this.listPrevSem});
}
