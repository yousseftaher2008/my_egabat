import 'package:get/get.dart';

import '../../../core/services/services.dart';
import '../../../routes/app_pages.dart';
import '../../main/controllers/main_controller.dart';

class WelcomeController extends GetxController {
  AppServices appServices = Get.find<AppServices>();
  Future<void> done() async {
    await setIsWelcomeViewed();
    Get.offAllNamed(Routes.AUTH);
  }

  Future<void> setIsWelcomeViewed() async {
    Get.find<MainController>().isWelcomeViewed = true;
    await appServices.pref.setBool("isWelcomeViewed", true);
  }
}
