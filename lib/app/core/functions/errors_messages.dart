import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool isOpen = false;
void whatsappLauncherError() {
  if (!isOpen) {
    isOpen = true;
    Get.snackbar(
      "لا يمكن فتح الواتساب".tr,
      "تاكد من وجود الواتساب على جهازك".tr,
      margin: const EdgeInsets.all(10),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    Future.delayed(const Duration(seconds: 3), () => isOpen = false);
  }
}
