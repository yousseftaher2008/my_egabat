import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeController extends GetxController {
  final RxBool isNext = true.obs;
  final RxBool isBack = false.obs;

  Future<void> done() async {
    await setIsViewed();
    Get.offAllNamed(Routes.AUTH);
  }

  Future<void> setIsViewed() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("isViewed", true);
  }
}
