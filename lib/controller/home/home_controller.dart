
import 'package:academicpanel/model/auth/user_model.dart';
import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/utility/error_widget/error_snackBar.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {

  HomeTopHeaderModel fetchHomePageHeader(UserModel userModel) {
    final lastName =  userModel.lastName;
    late String department;
    late String id;
    late DateTime dateTime;
    late String currentSmester;
    try {
      if (userModel.department.toUpperCase().trim() == 'CSE') {
        department = 'Computer'
      }
     return   HomeTopHeaderModel(lastName: lastName, department: department, id: id, dateTime: dateTime, currentSmester: currentSmester)

    } catch (e) {
       errorSnackbar(title: "Error", e: e);
      
      
    }
  }
}
