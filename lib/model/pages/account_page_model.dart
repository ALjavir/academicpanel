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
  final double due;
  final double waiver;
  final double paid;
  final double balance;
  final double fine;
  final double totalDue;
  final double totalPaid;

  AccountPageModelTopHeader({
    required this.due,
    required this.waiver,
    required this.paid,
    required this.balance,
    required this.totalDue,
    required this.totalPaid,
    required this.fine,
  });
}

class AccountPageModelInstallment {
  final String state;
  final double totalDue;
  final double totalPaid;
  final RowInstallmentModel installment;
  final RowFineModel? fineModel;
  AccountPageModelInstallment({
    required this.state,
    required this.installment,
    required this.totalDue,
    required this.totalPaid,
    this.fineModel,
  });
}

class AccountPageModelFullStatement {
  final List<RowInstallmentModel> installmentList;
  final List<RowAcStatementModel> accountStatementList;
  final List<RowFineModel> fineList;
  final List<RowPaymentModel> paymentList;
  final double balance;
  final double remaing;
  final double waiver;
  final double perCredit;
  AccountPageModelFullStatement({
    required this.installmentList,
    required this.accountStatementList,
    required this.fineList,
    required this.paymentList,
    required this.balance,
    required this.remaing,
    required this.waiver,
    required this.perCredit,
  });
}
