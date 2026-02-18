import 'package:academicpanel/controller/account/account_controller.dart';
import 'package:academicpanel/model/AccountSuperModel/account_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_fine_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_installment_model.dart';
import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class AccountPageController extends GetxController {
  final accountController = Get.find<AccountController>();
  double totalDue = 0;
  double totalPaid = 0;
  late AccountModel fetchAccountData;

  // @override
  // Future<void> onInit() async {
  //   super.onInit();

  //    await Future.wait([

  //   ]);

  // }

  Future<AccountPageModel> mainAccountPageController() async {
    try {
      fetchAccountData = await accountController.fetchAccountData();
      return AccountPageModel(
        accountPageModelTopHeader: await fetchAccountPageHeader(),
        accountPageModelInstallment: await fetchAccountPageInstallment(),
      );
    } catch (e) {
      return AccountPageModel(
        accountPageModelTopHeader: AccountPageModelTopHeader(
          balance: 0,
          due: 0,
          waiver: 0,
          paid: 0,
          totalDue: 0,
          totalPaid: 0,
          fine: 0,
        ),
        accountPageModelInstallment: [],
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

      totalDue = allDue - waiverAmount - (balance);

      totalPaid = allPaid - allFine;

      return AccountPageModelTopHeader(
        balance: balance,
        due: allDue,
        waiver: waiverAmount,
        paid: allPaid,
        totalDue: totalDue,
        totalPaid: totalPaid,
        fine: allFine,
      );
    } catch (e) {
      return AccountPageModelTopHeader(
        balance: 0,
        due: 0,
        waiver: 0,
        paid: 0,
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
      for (var i in installmentList) {
        // print(
        //   "${i.code} --------------------------------- ${i.amountPercentage}",
        // );
        String state;
        RowFineModel? subData;
        final finalData;
        final now = DateTime.now();
        final diffDays = i.deadline.difference(now).inDays;

        for (var j in fineList) {
          // print("this is i.code: ${i.code} and this is j.code ${j.code}");
          if (i.code == j.code) {
            subData = j;
          } else {
            subData = null;
          }
        }

        if (i.deadline.isBefore(now)) {
          state = "past";
        } else if (diffDays <= 14 && diffDays >= -1) {
          state = 'present';
        } else {
          state = 'future';
        }

        finalData = AccountPageModelInstallment(
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
}
