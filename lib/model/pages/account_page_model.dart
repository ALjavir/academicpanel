import 'package:academicpanel/model/AccountSuperModel/row_ac_statement_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_fine_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_installment_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_payment_model.dart';

class AccountPageModel {
  final AccountPageModelTopHeader accountPageModelTopHeader;
  final List<AccountPageModelInstallment> accountPageModelInstallment;
  final AccountPageModelBaseTutionFee accountPageModelBaseTutionFee;
  final AccountPageModelPayment accountPageModelPayment;
  AccountPageModel({
    required this.accountPageModelTopHeader,
    required this.accountPageModelInstallment,
    required this.accountPageModelBaseTutionFee,
    required this.accountPageModelPayment,
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

class AccountPageModelPayment {
  final List<RowPaymentModel> paymentList;
  final double totalPayment;
  AccountPageModelPayment({
    required this.paymentList,
    required this.totalPayment,
  });
}

class AccountPageModelBaseTutionFee {
  final List<RowAcStatementModel> accountStatementList;
  final double totalAccountStatementList;
  final double perCredit;
  AccountPageModelBaseTutionFee({
    required this.accountStatementList,
    required this.perCredit,
    required this.totalAccountStatementList,
  });
}
