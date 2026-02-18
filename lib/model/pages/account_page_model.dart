import 'package:academicpanel/model/AccountSuperModel/row_fine_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_installment_model.dart';

class AccountPageModel {
  final AccountPageModelTopHeader accountPageModelTopHeader;
  final List<AccountPageModelInstallment> accountPageModelInstallment;
  AccountPageModel({
    required this.accountPageModelTopHeader,
    required this.accountPageModelInstallment,
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
