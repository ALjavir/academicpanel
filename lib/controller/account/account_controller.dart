//class AccountController extrends GetxController {
// var accountData = {}.obs;
// Future<void> getAccountData(String department, String semester) async {
//   try {
//     DocumentSnapshot<Map<String, dynamic>> snapshot =
//         await fireBase_DataPath.accountData(department, semester).get();
//     if (snapshot.exists) {
//       accountData.value = snapshot.data() ?? {};
//     } else {
//       print('No account data found for $department - $semester');
//     }
//   } catch (e) {
//     print('Error fetching account data: $e');
//   }

//}

import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// class AccountController  extends GetxController {
//     final firebaseDatapath = Get.put(FirebaseDatapath());
//   final userController = Get.find<UserController>();

//   Future<void> getAccountData(String department, String semester, String student_id) async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> snapshot =
//           await fireBase_DataPath.accountData(department, semester, student_id).get();
//       if (snapshot.exists) {
//         accountData.value = snapshot.data() ?? {};
//       } else {
//         print('No account data found for $department - $semester - $student_id');
//       }
//     } catch (e) {
//       print('Error fetching account data: $e');
//     }
//   }
  
// }