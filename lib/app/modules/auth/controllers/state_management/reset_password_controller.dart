//TODO: edit the toast
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/base_url.dart';
import '../../../../core/constants/styles/colors.dart';
import 'auth_controller.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormState> teacherResetPassFromKey = GlobalKey<FormState>();
  final TextEditingController resetCodeController = TextEditingController();
  final TextEditingController teacherResetPassController =
      TextEditingController();
  final TextEditingController teacherResetPassController2 =
      TextEditingController();
  String? userId;
  String? expectedCode;

  Future<bool> requestCode(String email) async {
    const String url = '${baseUrl}Teacher/ForgetUserPassword';
    final body = {
      "email": email.trim(),
    };
    Map<String, String> head = {"Content-Type": "application/json"};
    final response =
        await http.post(Uri.parse(url), body: json.encode(body), headers: head);
    Map<String, dynamic> extractedData = json.decode(response.body);

    if (response.statusCode == 200) {
      userId = extractedData['id'];
      expectedCode = extractedData['token'];
      return true;
    } else {
      final String? errMessage = extractedData["errors"]["Message"];

      Get.snackbar(
        "${"حدث خطأ".tr} ${errMessage != null ? 'غير معروف'.tr : ''}",
        errMessage ?? '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColorLight,
        colorText: Colors.white,
      );

      return false;
    }
  }

  Future<void> resetPassword() async {
    if (!(teacherResetPassFromKey.currentState?.validate() ?? false)) {
      return;
    }
    const String url = '${baseUrl}Teacher/ResetUserPassword';
    final body = {
      "userId": userId,
      "token": resetCodeController.text,
      "newPassword": teacherResetPassController2.text,
    };
    Map<String, String> head = {"Content-Type": "application/json"};
    final response =
        await http.post(Uri.parse(url), body: json.encode(body), headers: head);
    if (response.statusCode == 200) {
      Get.find<AuthController>().isChangingPass.value = false;
    } else {
      // Fluttertoast.showToast(msg: 'يرجى المحاولة لاحقا');
    }
  }
}
