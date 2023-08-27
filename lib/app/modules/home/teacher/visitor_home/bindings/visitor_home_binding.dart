import 'package:get/get.dart';

import '../../../../auth/controllers/state_management/auth_controller.dart';
import '../../../../auth/controllers/state_management/register_controller.dart';
import '../controllers/visitor_home_controller.dart';

class VisitorHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitorHomeController>(
      () => VisitorHomeController(),
    );
    Get.delete<AuthController>(force: true);
    Get.delete<RegisterController>(force: true);
  }
}
