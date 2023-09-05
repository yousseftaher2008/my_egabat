import 'package:get/get.dart';
import 'package:my_egabat/app/core/services/services.dart';
import 'package:my_egabat/app/modules/main/controllers/main_controller.dart';
import '../../../routes/app_pages.dart';

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
