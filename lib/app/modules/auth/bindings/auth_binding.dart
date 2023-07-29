import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/register_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<RegisterController>(RegisterController(), permanent: true);
  }
}
