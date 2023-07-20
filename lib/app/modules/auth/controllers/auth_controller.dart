import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:libphonenumber/libphonenumber.dart';
import 'package:my_egabat/app/shared/errors/error_screen.dart';

import '../../../shared/base_url.dart';
import '../models/country_model.dart';

class AuthController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  String phoneNumber = "";
  String? errorText;
  final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();

  final RxBool isGettingCountries = false.obs;
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
    if (!(await isValidPhone())) {
      phoneKey.currentState!.validate();
      return;
    }
    phoneKey.currentState!.save();
    //todo: make authentication with API
  }

  Future<bool> isValidPhone() async {
    if (selectedCountry == null) {
      errorText = "اختر دولتك اولا";
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
    phoneNumber = phone;
    return true;
  }
}
