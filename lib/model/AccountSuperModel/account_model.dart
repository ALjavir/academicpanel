import 'package:academicpanel/model/AccountSuperModel/row_ac_statement_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_accountExt_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_fine_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_installment_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_payment_model.dart';

class AccountModel {
  final String current_sem;
  final List<RowFineModel> rowFineModelList;
  final List<RowAcStatementModel> rowAcSatementModelList;
  final List<RowInstallmentModel> rowInstallmentModelList;
  final List<RowPaymentModel> rowPaymentModelList;
  final RowAccountextModel rowAccountextModel;

  AccountModel({
    required this.rowAcSatementModelList,
    required this.rowInstallmentModelList,
    required this.rowPaymentModelList,
    required this.rowAccountextModel,
    required this.current_sem,
    required this.rowFineModelList,
  });
}
