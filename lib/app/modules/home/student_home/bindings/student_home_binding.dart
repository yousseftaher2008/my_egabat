import 'package:get/get.dart';

import '../../../auth/controllers/state_management/auth_controller.dart';
import '../../../auth/controllers/state_management/register_controller.dart';
import '../controllers/student_home_controller.dart';

class StudentHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentHomeController>(
      () => StudentHomeController(),
    );
    Get.delete<AuthController>(force: true);
    Get.delete<RegisterController>(force: true);
  }
}
