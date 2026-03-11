import 'package:academicpanel/model/AccountSuperModel/row_ac_statement_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_fine_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_installment_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_payment_model.dart';

class AccountPageModel {
  final AccountPageModelTopHeader accountPageModelTopHeader;
  final List<AccountPageModelInstallment> accountPageModelInstallment;
  final AccountPageModelFullStatement accountPageModelFullStatement;
  AccountPageModel({
    required this.accountPageModelTopHeader,
    required this.accountPageModelInstallment,
    required this.accountPageModelFullStatement,
  });
}

class AccountPageModelTopHeader {
  final double statementDue;
  final double waiver;

  final double balance;
  final double totalFine;
  final double totalDue;
  final double totalPaid;

  AccountPageModelTopHeader({
    required this.statementDue,
    required this.waiver,

    required this.balance,
    required this.totalDue,
    required this.totalPaid,
    required this.totalFine,
  });
}

class AccountPageModelInstallment {
  final String state;
  final double totalDue;
  final double totalPaid;
  final RowInstallmentModel installment;
  final RowFineModel fineModel;
  AccountPageModelInstallment({
    required this.state,
    required this.installment,
    required this.totalDue,
    required this.totalPaid,
    required this.fineModel,
  });
}

class AccountPageModelFullStatement {
  final List<RowAcStatementModel> accountStatementList;
  final List<RowFineModel> fineList;
  final List<RowPaymentModel> paymentList;

  final double totalAccountStatementList;
  final double totalFineList;
  final double totalPaymentList;
  final double balance;
  final double remaing;
  final int waiverPer;
  final double waiverAmount;
  final double perCredit;
  AccountPageModelFullStatement({
    required this.accountStatementList,
    required this.fineList,
    required this.paymentList,
    required this.balance,
    required this.remaing,
    required this.waiverPer,
    required this.perCredit,
    required this.totalAccountStatementList,
    required this.totalFineList,
    required this.totalPaymentList,
    required this.waiverAmount,
  });
}
