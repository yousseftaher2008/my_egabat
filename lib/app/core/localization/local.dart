import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/data/models/app_local.dart';

import '../services/services.dart';

AppLocal appLocal = AppLocal.ar;

class LocaleController extends GetxController {
  Locale? language;

  AppServices appServices = Get.find();

  changeLang(String langCode) {
    Locale locale = Locale(langCode);
    appServices.pref.setString("lang", langCode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = appServices.pref.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
    } else if (sharedPrefLang == "en") {
      appLocal = AppLocal.en;
      language = const Locale("en");
    } else {
      appLocal = AppLocal.en;
      language = const Locale("en");
    }
    super.onInit();
  }
}
