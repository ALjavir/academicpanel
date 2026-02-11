import 'package:academicpanel/controller/account/account_controller.dart';
import 'package:academicpanel/model/AccountSuperModel/account_model.dart';
import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class AccountPageController extends GetxController {
  final accountController = Get.find<AccountController>();
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
      double totalFine = 0;

      for (var i in fetchAccountData.rowAcSatementModelList) {
        allDue += i.amount;
      }
      for (var i in fetchAccountData.rowPaymentModelList) {
        allPaid += i.amount;
      }
      for (var i in fetchAccountData.rowFineModelList) {
        totalFine += i.amount;
      }

      final double waiverAmount = allDue * (waiverPer / 100);

      final double totalFeeAfterWaiver = allDue - waiverAmount;

      final double netPaidForTuition = allPaid - totalFine + balance;

      return AccountPageModelTopHeader(
        balance: balance,
        due: allDue,
        waiver: waiverAmount,
        paid: allPaid,
        totalDue: totalFeeAfterWaiver,
        totalPaid: netPaidForTuition,
      );
    } catch (e) {
      return AccountPageModelTopHeader(
        balance: 0,
        due: 0,
        waiver: 0,
        paid: 0,
        totalDue: 0,
        totalPaid: 0,
      );
    }
  }
}
