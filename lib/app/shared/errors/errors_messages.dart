import 'package:flutter/material.dart';
import 'package:get/get.dart';

void whatsappLauncherError() {
  Get.closeCurrentSnackbar();
  Get.snackbar(
    "لا يمكن فتح الواتساب".tr,
    "تاكد من وجود الواتساب على جهازك".tr,
    margin: const EdgeInsets.all(10),
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
  );
}
