import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

final userController = Get.find<UserController>();

class RowCgpaCrModel {
  final double credit_completed;
  final double target_credit;
  final double credit_enrolled;
  final double pervious_cgpa;
  final double current_cgpa;
  final String comment;

  RowCgpaCrModel({
    required this.credit_completed,
    required this.target_credit,
    required this.credit_enrolled,
    required this.pervious_cgpa,
    required this.current_cgpa,
    required this.comment,
  });
  factory RowCgpaCrModel.fromMap(Map<String, dynamic> map) {
    double credit_enrolled = 0.0;

    final userModel = userController.user.value;
    final courses = userModel?.current_course ?? {};

    for (var i in courses.values) {
      credit_enrolled += (i['credit'] ?? 0) as num;
    }

    return RowCgpaCrModel(
      comment: map['comment'] ?? 'TBA',

      credit_completed: (map['credit_completed'] ?? 0).toDouble(),
      target_credit: (map['target_credit'] ?? 0).toDouble(),

      pervious_cgpa: (map['pervious_cgpa'] ?? 0).toDouble(),
      current_cgpa: (map['current_cgpa'] ?? 0).toDouble(),
      credit_enrolled: credit_enrolled.toDouble(),
    );
  }
}
