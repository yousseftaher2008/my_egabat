import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/state_management/auth_controller.dart';
import 'package:my_egabat/app/modules/auth/controllers/state_management/register_controller.dart';

import '../controllers/teacher_home_controller.dart';

class TeacherHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherHomeController>(
      () => TeacherHomeController(),
    );
    Get.delete<AuthController>(force: true);
    Get.delete<RegisterController>(force: true);
  }
}
