import 'package:academicpanel/controller/account/account_controller.dart';
import 'package:academicpanel/model/AccountSuperModel/account_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_ac_statement_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_fine_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_installment_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_payment_model.dart';
import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class AccountPageController extends GetxController {
  final accountController = Get.find<AccountController>();
  late double totalFDue;
  late double totalFPaid;
  late double waiverAmount;
  late AccountModel fetchAccountData;

  Future<AccountPageModel> mainAccountPageController() async {
    try {
      fetchAccountData = await accountController.fetchAccountData();
      return AccountPageModel(
        accountPageModelTopHeader: await fetchAccountPageHeader(),
        accountPageModelInstallment: await fetchAccountPageInstallment(),
        accountPageModelFullStatement: await fetchAccountPageFullStatement(),
      );
    } catch (e) {
      return AccountPageModel(
        accountPageModelTopHeader: AccountPageModelTopHeader(
          balance: 0,
          statementDue: 0,
          waiver: 0,

          totalDue: 0,
          totalPaid: 0,
          totalFine: 0,
        ),
        accountPageModelInstallment: [],
        accountPageModelFullStatement: AccountPageModelFullStatement(
          accountStatementList: [],
          fineList: [],
          paymentList: [],
          balance: 0,
          remaing: 0,
          waiverPer: 0,
          perCredit: 0,
          totalAccountStatementList: 0,
          totalFineList: 0,
          totalPaymentList: 0,
          waiverAmount: 0,
        ),
      );
    }
  }

  Future<AccountPageModelTopHeader> fetchAccountPageHeader() async {
    try {
      final double balance = fetchAccountData.rowAccountextModel.balance;
      final int waiverPer = fetchAccountData.rowAccountextModel.waiver;

      double statementDue = 0;

      double totalPaid = 0;
      double totalFine = 0;

      for (var i in fetchAccountData.rowAcSatementModelList) {
        statementDue += i.amount;
      }
      for (var i in fetchAccountData.rowPaymentModelList) {
        totalPaid += i.amount;
      }
      for (var i in fetchAccountData.rowFineModelList) {
        totalFine += i.amount;
      }

      waiverAmount = statementDue * (waiverPer / 100);
      totalFPaid = totalPaid;
      totalFDue = (statementDue + totalFine) - (waiverAmount + (balance));

      return AccountPageModelTopHeader(
        balance: balance,
        statementDue: statementDue,
        waiver: waiverAmount,
        totalDue: totalFDue,
        totalPaid: totalFPaid,
        totalFine: totalFine,
      );
    } catch (e) {
      return AccountPageModelTopHeader(
        balance: 0,
        statementDue: 0,
        waiver: 0,
        totalDue: 0,
        totalPaid: 0,
        totalFine: 0,
      );
    }
  }

  Future<List<AccountPageModelInstallment>>
  fetchAccountPageInstallment() async {
    try {
      final List<AccountPageModelInstallment> accountPageModelInstallmentList =
          [];

      final List<RowInstallmentModel> installmentList =
          fetchAccountData.rowInstallmentModelList;
      final List<RowFineModel> fineList = fetchAccountData.rowFineModelList;
      // final List<RowPaymentModel> paymentList =
      //     fetchAccountData.rowPaymentModelList;

      final now = DateTime.now();
      String code = '';
      double target = 0;
      double paid = 0;
      double amount = 0;

      for (var i in installmentList) {
        String state;
        RowFineModel subData = RowFineModel(
          code: code,
          created_at: now,
          target: target,
          paid: paid,
          amount: amount,
        );

        for (var j in fineList) {
          if (i.code == j.code) {
            subData = j;
            break;
          }
        }

        final diffDays = i.deadline.difference(now).inDays;

        if (i.deadline.isBefore(now) && diffDays < 0) {
          state = "past";
        } else if (diffDays <= 14 && diffDays >= 0) {
          state = 'present';
        } else {
          state = 'future';
        }
        final finalData = AccountPageModelInstallment(
          installment: i,
          state: state,
          totalDue: totalFDue,
          totalPaid: totalFPaid,
          fineModel: subData,
        );

        accountPageModelInstallmentList.add(finalData);
      }

      return accountPageModelInstallmentList.reversed.toList();
    } catch (e) {
      return [];
    }
  }

  Future<AccountPageModelFullStatement> fetchAccountPageFullStatement() async {
    try {
      final double balance = fetchAccountData.rowAccountextModel.balance;
      final int waiverPer = fetchAccountData.rowAccountextModel.waiver;
      final double perCredit = fetchAccountData.rowAccountextModel.perCreditFee;
      final List<RowAcStatementModel> accountStatement =
          fetchAccountData.rowAcSatementModelList;
      final List<RowFineModel> fine = fetchAccountData.rowFineModelList;
      final List<RowPaymentModel> paymentList =
          fetchAccountData.rowPaymentModelList;
      double remaing = 0;
      double totalAccountStatementList = 0;
      double totalFineList = 0;
      double totalPaymentList = 0;

      for (var i in accountStatement) {
        totalAccountStatementList += i.amount;
      }
      for (var i in fine) {
        totalAccountStatementList += i.amount;
      }
      for (var i in paymentList) {
        totalAccountStatementList += i.amount;
      }

      accountStatement.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      fine.sort((a, b) => a.created_at.compareTo(b.created_at));
      paymentList.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      return AccountPageModelFullStatement(
        accountStatementList: accountStatement,
        fineList: fine,
        paymentList: paymentList,
        balance: balance,
        remaing: remaing,
        waiverPer: waiverPer,
        perCredit: perCredit,
        totalAccountStatementList: totalAccountStatementList,
        totalFineList: totalFineList,
        totalPaymentList: totalPaymentList,
        waiverAmount: waiverAmount,
      );
    } catch (e) {
      return AccountPageModelFullStatement(
        accountStatementList: [],
        fineList: [],
        paymentList: [],
        balance: 0,
        remaing: 0,
        waiverPer: 0,
        perCredit: 0,
        totalAccountStatementList: 0,
        totalFineList: 0,
        totalPaymentList: 0,
        waiverAmount: 0,
      );
    }
  }
}
