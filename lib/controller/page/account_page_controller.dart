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
  late double totalDue;
  late double totalPaid;
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
          due: 0,
          waiver: 0,

          totalDue: 0,
          totalPaid: 0,
          fine: 0,
        ),
        accountPageModelInstallment: [],
        accountPageModelFullStatement: AccountPageModelFullStatement(
          accountStatementList: [],
          fineList: [],
          paymentList: [],
          balance: 0,
          remaing: 0,
          waiver: 0,
          perCredit: 0,
          totalAccountStatementList: 0,
          totalFineList: 0,
          totalPaymentList: 0,
        ),
      );
    }
  }

  Future<AccountPageModelTopHeader> fetchAccountPageHeader() async {
    try {
      final double balance = fetchAccountData.rowAccountextModel.balance;
      final double waiverPer = fetchAccountData.rowAccountextModel.waiver;

      double allPaid = 0;
      double allDue = 0;
      double allFine = 0;

      for (var i in fetchAccountData.rowAcSatementModelList) {
        allDue += i.amount;
      }
      for (var i in fetchAccountData.rowPaymentModelList) {
        allPaid += i.amount;
      }
      for (var i in fetchAccountData.rowFineModelList) {
        allFine += i.amount;
      }

      final double waiverAmount = allDue * (waiverPer / 100);

      totalDue = allDue - waiverAmount - (balance) - allFine;
      totalPaid = allPaid;

      print("This is the total paid from account page: $totalPaid");

      return AccountPageModelTopHeader(
        balance: balance,
        due: allDue,
        waiver: waiverAmount,
        totalDue: totalDue,
        totalPaid: totalPaid,
        fine: allFine,
      );
    } catch (e) {
      return AccountPageModelTopHeader(
        balance: 0,
        due: 0,
        waiver: 0,
        totalDue: 0,
        totalPaid: 0,
        fine: 0,
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

      for (var i in installmentList) {
        String state;
        RowFineModel subData = RowFineModel(
          code: '',
          created_at: now,
          target: 0,
          paid: 0,
          amount: 0,
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
          totalDue: totalDue,
          totalPaid: totalPaid,
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
      final double waiver = fetchAccountData.rowAccountextModel.waiver;
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
        waiver: waiver,
        perCredit: perCredit,
        totalAccountStatementList: totalAccountStatementList,
        totalFineList: totalFineList,
        totalPaymentList: totalPaymentList,
      );
    } catch (e) {
      return AccountPageModelFullStatement(
        accountStatementList: [],
        fineList: [],
        paymentList: [],
        balance: 0,
        remaing: 0,
        waiver: 0,
        perCredit: 0,
        totalAccountStatementList: 0,
        totalFineList: 0,
        totalPaymentList: 0,
      );
    }
  }
}
