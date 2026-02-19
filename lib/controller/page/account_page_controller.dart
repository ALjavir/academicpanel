import 'package:academicpanel/controller/account/account_controller.dart';
import 'package:academicpanel/model/AccountSuperModel/account_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_fine_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_installment_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_payment_model.dart';
import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class AccountPageController extends GetxController {
  final accountController = Get.find<AccountController>();
  late double totalDue;
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

      final double totalPaid;
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
      final List<RowPaymentModel> paymentList =
          fetchAccountData.rowPaymentModelList;

      final now = DateTime.now();

      for (var i in installmentList) {
        double totalPaid = 0.0;
        String state;
        RowFineModel? subData;

        for (var j in fineList) {
          if (i.code == j.code) {
            subData = j;
          } else {
            for (var j in paymentList) {
              if (j.createdAt.isBefore(i.deadline) ||
                  j.createdAt.isAtSameMomentAs(i.deadline)) {
                totalPaid += j.amount;
              }
            }
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
}
