import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart' as dio;
import 'package:libphonenumber/libphonenumber.dart';
import 'package:my_egabat/app/modules/main/controllers/main_controller.dart';
import '../bindings/register_binding.dart';
import 'image_input_controller.dart';
import 'register_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/errors/error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/base_url.dart';
import '../models/country_model.dart';

class AuthController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  String phoneNumber = "";
  String? errorText;
  RegisterController? registerController;
  MainController mainController = Get.find<MainController>();
  final RxBool isRegister = false.obs;
  final RxBool isFirstRegisterStep = false.obs;
  final RxBool isGettingCountries = false.obs;
  final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();
  List<Country> countries = [];
  Country? selectedCountry;
  final RxString selectedCountryCode = "اختر دولتك".obs;

  final RxBool isTeacher = false.obs;

  Future<void> getCountries() async {
    if (countries.isNotEmpty) {
      return;
    }
    isGettingCountries.value = true;
    final Uri url = Uri.parse("${baseUrl}Countries/GetAllCountries");
    try {
      final response = await dio.Dio().getUri(url);

      print(response.statusCode);
      if ((response.statusCode ?? 200) <= 400) {
        final jsonCountries = json.decode(response.data);

        for (final country in jsonCountries) {
          countries.add(Country.fromJson(country));
        }
      }
    } catch (e) {
      Get.offAll(const ErrorScreen());
    }
    isGettingCountries.value = false;
  }

  Future<void> login() async {
    if (isRegister.value) {
      await registerController?.register();
      return;
    }
    final isValidPhon = await isValidPhone();
    phoneKey.currentState!.validate();
    if (!isValidPhon) {
      return;
    }
    phoneKey.currentState!.save();
    //todo: make authentication with API
    final Uri url = Uri.parse('${baseUrl}Student/Login');
    final fbm = FirebaseMessaging.instance;
    final String? deviceToken = await fbm.getToken();
    final body = json.encode({
      'mobile': phoneNumber,
      'deviceToken': deviceToken,
    });
    Map<String, String> head = {
      "Content-Type": "application/json",
      'accept': "*/*",
    };
    final response = await dio.Dio()
        .postUri(url, data: body, options: dio.Options(headers: head));
    final Map<String, dynamic> responseData = json.decode(response.data);
    if ((responseData["isActive"] ?? false) == false) {
      Get.offAll(const ErrorScreen());
      return;
    }
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("userId", responseData["studentId"] ?? "");
    await pref.setString("token", responseData["token"] ?? "");
    await pref.setBool("isLogin", responseData["isExist"] ?? false);
    await mainController.getAuthData();
    if ((responseData["isExist"] ?? false) == true) {
      Get.offAllNamed(Routes.HOME);
    } else {
      nextRegisterStep();
    }
  }

  Future<bool> isValidPhone() async {
    if (selectedCountry == null) {
      errorText = "اختر دولتك اولا";
      return false;
    }
    if (phoneController.value.text == "") {
      errorText = "أدخل رقما ";
      return false;
    }
    final String? phone = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: phoneController.text, isoCode: selectedCountry!.isoCode);
    if (phone == null) {
      errorText = "أدخل رقما صحيحا";

      return false;
    }

    final bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: phone, isoCode: selectedCountry!.isoCode);
    if (!(isValid ?? false)) {
      errorText = "أدخل رقما صحيحا";
      return false;
    }

    errorText = null;
    phoneNumber = phone;
    return true;
  }

  void selectCountryByCode(String value) {
    for (int i = 0; i < countries.length; i++) {
      if (countries[i].code != value || selectedCountryCode.value == value) {
        continue;
      }
      selectedCountry = countries[i];
      selectedCountryCode.value = value;
    }
  }

  void nextRegisterStep() {
    // going to register page
    if (!isRegister.value) {
      RegisterBinding().dependencies();
      registerController = Get.find<RegisterController>();
      isFirstRegisterStep.value = true;
      isRegister.value = true;
    } else {
      if (!(registerController!.formKey.currentState?.validate() ?? true)) {
        return;
      }
      isFirstRegisterStep.value = false;
    }
  }

  void backFromRegister() {
    // back to register page
    if (isFirstRegisterStep.value) {
      Get.delete<RegisterController>();
      Get.delete<ImageInputController>();
      isRegister.value = false;
      isFirstRegisterStep.value = false;
    } else {
      isFirstRegisterStep.value = true;
    }
  }
}
