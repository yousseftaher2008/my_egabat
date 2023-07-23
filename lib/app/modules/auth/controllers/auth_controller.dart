import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:libphonenumber/libphonenumber.dart';
import 'package:my_egabat/app/modules/auth/bindings/register_binding.dart';
import 'package:my_egabat/app/modules/auth/controllers/register_controller.dart';
import 'package:my_egabat/app/routes/app_pages.dart';
import 'package:my_egabat/app/shared/errors/error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/base_url.dart';
import '../models/country_model.dart';

class AuthController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  String phoneNumber = "";
  String? errorText;
  RegisterController? registerController;
  final RxBool isRegister = false.obs;
  final RxBool isGettingCountries = false.obs;
  final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();
  List<Country> countries = [];
  Country? selectedCountry;
  final RxString selectedCountryCode = "اختر دولتك".obs;

  Future<void> getCountries() async {
    if (countries.isNotEmpty) {
      return;
    }
    isGettingCountries.value = true;
    final Uri url = Uri.parse("${baseUrl}Countries/GetAllCountries");
    try {
      final response = await http.get(url);
      if (response.statusCode <= 400) {
        final jsonCountries = json.decode(response.body);

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
    final response = await http.post(url, body: body, headers: head);
    final Map<String, dynamic> responseData = json.decode(response.body);
    if ((responseData["isActive"] ?? false) == false) {
      Get.offAll(const ErrorScreen());
      return;
    }
    final pref = await SharedPreferences.getInstance();
    pref.setString("userId", responseData["studentId"] ?? "");
    pref.setString("token", responseData["token"] ?? "");
    pref.setBool("isLogin", responseData["isExist"] ?? false);
    if ((responseData["isExist"] ?? false) == true) {
      Get.offAllNamed(Routes.HOME);
      //going to home
    } else {
      // going to register page
      RegisterBinding().dependencies();
      registerController = Get.find<RegisterController>();
      isRegister.value = true;
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
}
