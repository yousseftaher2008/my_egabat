//TODO: default snackBars styles
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/core/constants/styles/colors.dart';
import 'app/core/localization/local.dart';
import 'app/core/localization/translation.dart';
import 'app/core/services/services.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  // await ScreenUtil.ensureScreenSize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  LocaleController controller = Get.put<LocaleController>(LocaleController());
  runApp(
    GetMaterialApp(
      // textDirection: TextDirection.rtl,
      title: "Ai School",
      locale: controller.language,

      translations: MyTranslation(),
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.light(secondary: primaryColorLight),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
