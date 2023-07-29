import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart';
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

class AuthController extends MainController {
  final TextEditingController phoneController = TextEditingController();
  String phoneNumber = "";
  String? errorText;
  RegisterController? registerController;
  final RxBool isRegister = false.obs;
  final RxBool isFirstRegisterStep = false.obs;
  final RxBool isGettingCountries = false.obs;
  final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();
  List<Country> countries = [];
  Country? _selectedCountry;
  final RxString selectedCountryCode = "اختر دولتك".obs;

  final RxBool isTeacher = false.obs;

  Country? get selectedCountry => _selectedCountry;
  Future<void> getCountries() async {
    if (countries.isNotEmpty) {
      return;
    }
    isGettingCountries.value = true;
    const url = ("${baseUrl}Countries/GetAllCountries");
    try {
      final response = await dio.Dio().get(url);
      if ((response.statusCode ?? 200) < 400) {
        for (final country in response.data) {
          countries.add(Country.fromJson(country));
        }
      }
    } catch (e) {
      print(e);
      // Get.offAll(const ErrorScreen());
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
    try {
      const url = ('${baseUrl}Student/Login');
      final body = json.encode({
        'mobile': phoneNumber,
        'deviceToken': deviceToken,
      });
      Map<String, String> head = {
        "Content-Type": "application/json",
        'accept': "*/*",
      };
      final response = await post(Uri.parse(url), body: body, headers: head);
      print(response.body);
      if ((response.statusCode) >= 400) {
        Get.offAll(const ErrorScreen());
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      if ((responseData["isActive"] ?? false) == false) {
        Get.offAll(const ErrorScreen());
        return;
      }
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("userId", responseData["studentId"] ?? "");
      await pref.setString("token", responseData["token"] ?? "");
      await pref.setBool("isLogin", responseData["isExist"] ?? false);
      await getAuthData();
      if ((responseData["isExist"] ?? false) == true) {
        Get.offAllNamed(Routes.HOME);
      } else {
        nextRegisterStep();
      }
    } catch (e) {
      print(e);
      Get.offAll(const ErrorScreen());
    }
  }

  Future<bool> isValidPhone() async {
    if (_selectedCountry == null) {
      errorText = "اختر دولتك اولا";
      return false;
    }
    if (phoneController.value.text == "") {
      errorText = "أدخل رقما ";
      return false;
    }
    final String? phone = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: phoneController.text, isoCode: _selectedCountry!.isoCode);
    if (phone == null) {
      errorText = "أدخل رقما صحيحا";

      return false;
    }

    final bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: phone, isoCode: _selectedCountry!.isoCode);
    if (!(isValid ?? false)) {
      errorText = "أدخل رقما صحيحا";
      return false;
    }

    errorText = null;
    phoneNumber = phone;
    return true;
  }

  void selectCountryByCode(String value) {
    print("called");
    for (int i = 0; i < countries.length; i++) {
      if (countries[i].code != value || selectedCountryCode.value == value) {
        continue;
      }
      _selectedCountry = countries[i];
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

  void changeUserType() {
    isRegister.value = false;
    isFirstRegisterStep.value = false;
    isTeacher.value = !isTeacher.value;
  }
}
