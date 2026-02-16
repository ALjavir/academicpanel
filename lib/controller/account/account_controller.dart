import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/model/AccountSuperModel/account_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_ac_statement_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_accountExt_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_fine_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_installment_model.dart';
import 'package:academicpanel/model/AccountSuperModel/row_payment_model.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AccountController extends GetxController {
  final firebaseDatapath = Get.find<FirebaseDatapath>();
  final userController = Get.find<UserController>();

  Future<AccountModel> fetchAccountData() async {
    try {
      final userModel = userController.user.value;
      if (userModel == null) throw Exception("User not logged in");
      final studentId = userModel.id;
      final department = userModel.department;
      String current_sem = "";
      final List<RowFineModel> rowFineModelList = [];
      final List<RowAcStatementModel> rowAcSatementModelList = [];
      final List<RowInstallmentModel> rowInstallmentModelList = [];
      final List<RowPaymentModel> rowPaymentModelList = [];
      RowAccountextModel? rowAccountextModel;
      final deptSnapshot = await firebaseDatapath.accountData(department).get();
      final deptData = deptSnapshot.data();
      if (deptData != null) {
        current_sem = deptData['current_sem']?.toString() ?? "";
        final installmentMap = Map<String, dynamic>.from(
          deptData['installment'] ?? {},
        );
        for (var v in installmentMap.values) {
          rowInstallmentModelList.add(RowInstallmentModel.fromMap(v));
        }
        rowInstallmentModelList.sort((a, b) => b.code.compareTo(a.code));
      }

      final studentSnapshot = await firebaseDatapath
          .accountData(department)
          .collection('student_id')
          .doc(studentId)
          .get();
      if (studentSnapshot.exists && studentSnapshot.data() != null) {
        rowAccountextModel = RowAccountextModel.fromMap(
          studentSnapshot.data()!,
        );
      } else {
        rowAccountextModel = RowAccountextModel(
          balance: 0,
          perCreditFee: 0,
          waiver: 0,
        );
      }

      if (current_sem.isNotEmpty) {
        final semSnapshot = await firebaseDatapath
            .accountData(department)
            .collection('student_id')
            .doc(studentId)
            .collection('semester')
            .doc(current_sem)
            .get();
        final semData = semSnapshot.data();
        if (semSnapshot.exists && semData != null) {
          final fineMap = Map<String, dynamic>.from(semData['fine'] ?? {});
          for (var v in fineMap.values) {
            rowFineModelList.add(RowFineModel.fromMap(v));
          }

          final paymentList = Map<String, dynamic>.from(
            semData['payment'] ?? [],
          );
          for (var v in paymentList.values) {
            rowPaymentModelList.add(RowPaymentModel.fromMap(v));
          }

          final statementMap = Map<String, dynamic>.from(
            semData['ac_statement'] ?? {},
          );
          for (var v in statementMap.values) {
            rowAcSatementModelList.add(RowAcStatementModel.fromMap(v));
          }
        }
      }

      return AccountModel(
        rowAcSatementModelList: rowAcSatementModelList,
        rowInstallmentModelList: rowInstallmentModelList,
        rowPaymentModelList: rowPaymentModelList,
        rowAccountextModel: rowAccountextModel,
        current_sem: current_sem,
        rowFineModelList: rowFineModelList,
      );
    } catch (e) {
      print('Error fetching account data: $e');
      return AccountModel(
        rowAcSatementModelList: [],
        rowInstallmentModelList: [],
        rowPaymentModelList: [],
        rowAccountextModel: RowAccountextModel(
          balance: 0,
          perCreditFee: 0,
          waiver: 0,
        ),
        current_sem: '',
        rowFineModelList: [],
      );
    }
  }
}
