import 'dart:convert';

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:dio/dio.dart" as dio;
import "package:http/http.dart" as http;
import "package:libphonenumber/libphonenumber.dart";
import "package:my_egabat/app/modules/auth/bindings/reset_password_binding.dart";
import "package:my_egabat/app/modules/auth/controllers/state_management/reset_password_controller.dart";
import "package:my_egabat/app/modules/main/controllers/main_controller.dart";
import "../../../../routes/app_pages.dart";
import '../../../../core/constants/styles/colors.dart';
import 'register_controller.dart';
import '../../../../core/shared/errors/error_screen.dart';

import '../../../../core/constants/base_url.dart';
import '../../../../data/models/country_model.dart';

class AuthController extends MainController {
  //phone properties
  final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();
  final TextEditingController phoneController = TextEditingController();
  String phoneNumber = "";
  String? errorText;
  // teacher properties
  final TextEditingController teacherEmailController = TextEditingController();
  final TextEditingController teacherPassController = TextEditingController();
  final GlobalKey<FormState> teacherFromKey = GlobalKey<FormState>();
  //controllers
  late final RegisterController registerController;
  //country properties
  List<Country> countries = [];
  Country? selectedCountry;
  final RxString selectedCountryCode = "اختر دولتك".tr.obs;
  //boolean values
  final RxBool isGettingCountries = false.obs;
  final RxBool isTeacher = false.obs;
  final RxBool isChangingPass = false.obs;
  final RxBool isLogging = false.obs;
  final RxBool isInit = true.obs;

  @override
  onReady() async {
    super.onReady();
    Get.put(RegisterController(), permanent: true);
    registerController = Get.find<RegisterController>();
    isInit.value = false;
  }

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
      Get.offAll(() => const ErrorScreen());
    }
    isGettingCountries.value = false;
  }

  Future<void> studentLogin() async {
    if (!isLogging.value) {
      isLogging.value = true;
      final isValidPhon = await isValidPhone();
      if (!isValidPhon) {
        phoneKey.currentState!.validate();
        isLogging.value = false;
        return;
      }
      phoneKey.currentState!.save();
      try {
        const url = ('${baseUrl}Student/Login');
        final body = json.encode({
          "mobile": phoneNumber,
          "deviceToken": deviceToken,
        });
        Map<String, String> head = {
          "Content-Type": "application/json",
          "accept": "*/*",
        };
        final response =
            await http.post(Uri.parse(url), body: body, headers: head);
        if ((response.statusCode) >= 400) {
          isLogging.value = false;
          Get.offAll(() => const ErrorScreen());

          return;
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if ((responseData["isActive"] ?? false) == false) {
            isLogging.value = false;
            Get.offAll(const ErrorScreen());
            return;
          }
          await appServices.pref
              .setString("userId", responseData["studentId"] ?? "");
          await appServices.pref
              .setString("token", responseData["token"] ?? "");
          await appServices.pref
              .setBool("isLogin", responseData["isExist"] ?? false);
          await getAuthData();
          if ((responseData["isExist"] ?? false)) {
            isLogging.value = false;
            Get.offAllNamed(Routes.STUDENT_HOME);
            await clearControllers();
            return;
          } else {
            isLogging.value = false;
            registerController.nextRegisterStep();
          }
        }
      } catch (e) {
        isLogging.value = false;
        Get.offAll(const ErrorScreen());
      }
    }
  }

  Future<void> teacherLogin() async {
    if (!isLogging.value) {
      isLogging.value = true;
      if (!(teacherFromKey.currentState?.validate() ?? false)) {
        isLogging.value = false;
        return;
      }
      try {
        final body = {
          "username": teacherEmailController.text.trim(),
          "password": teacherPassController.text.trim(),
          "deviceToken": deviceToken,
        };

        final Uri url = Uri.parse("${baseUrl}Teacher/Login");
        Map<String, String> head = {"Content-Type": "application/json"};
        final response = await http.post(
          url,
          body: json.encode(body),
          headers: head,
        );
        if ((response.statusCode) < 400) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          await appServices.pref.setBool("isLogin", true);
          await appServices.pref
              .setString('token', responseData["token"] ?? "");
          await appServices.pref
              .setBool('isFreeTrial', responseData['isFreeTrial'] ?? false);
          await appServices.pref.setBool(
              'isVisitingTeacher', responseData['isVisitingTeacher'] ?? false);

          isLogging.value = false;
          (responseData["isVisitingTeacher"] == true)
              ? Get.offAllNamed(Routes.VISITOR_HOME)
              : Get.offAllNamed(Routes.TEACHER_HOME);
          await clearControllers();
        } else if (response.statusCode == 401) {
          Get.defaultDialog(
            title: "الشفره خاطئه",
            middleText: "هل تريد تغير الشفرة؟",
            cancel: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(
                  color: primaryColor,
                  width: 2,
                ),
                foregroundColor: primaryColor,
              ),
              child: const Text("العودة"),
            ),
            confirm: ElevatedButton(
              onPressed: () async {
                Get.back();
                ResetPasswordBinding().dependencies();
                if ((await Get.find<ResetPasswordController>()
                    .requestCode(teacherEmailController.text))) {
                  isChangingPass.value = true;
                }
              },
              child: const Text("تغير الشفرة"),
            ),
          );
          isLogging.value = false;
        } else {
          isLogging.value = false;
          Get.offAll(() => const ErrorScreen());
        }
      } catch (e) {
        isLogging.value = false;
        Get.offAll(() => const ErrorScreen());
      }
      isLogging.value = false;
    }
  }

  Future<bool> isValidPhone() async {
    if (selectedCountry == null) {
      errorText = "اختر دولتك اولا".tr;
      return false;
    }
    if (phoneController.value.text == "") {
      errorText = "أدخل رقما".tr;
      return false;
    }
    final String? phone = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: phoneController.text, isoCode: selectedCountry!.isoCode);
    if (phone == null) {
      errorText = "أدخل رقما صحيحا".tr;

      return false;
    }

    final bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: phone, isoCode: selectedCountry!.isoCode);
    if (!(isValid ?? false)) {
      errorText = "أدخل رقما صحيحا".tr;
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

  void changeUserType() {
    registerController.isRegister.value = false;
    isChangingPass.value = false;
    registerController.isFirstRegisterStep.value = false;
    isTeacher.value = !isTeacher.value;
    registerController.clearFirstPageInputs();
    registerController.clearSecondPageInputs();
    teacherEmailController.clear();
    teacherPassController.clear();
    phoneController.clear();
    selectedCountry = null;
    selectedCountryCode.value = "اختر دولتك".tr;
  }

  Future<void> clearControllers() async {
    await Future.delayed(const Duration(milliseconds: 1));
    Get.delete<AuthController>(force: true);
    Get.delete<RegisterController>(force: true);
  }
}


/*
  {
    studentId: ee0c4eb1-473f-4a62-bb60-08dbaddb70be,
    token: eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJnaXZlbl9uYW1lIjoiKzk2NTk5OTk5OTk5IiwiZW1haWwiOiIrOTY1OTk5OTk5OTkiLCJuYW1laWQiOiJlZTBjNGViMS00NzNmLTRhNjItYmI2MC0wOGRiYWRkYjcwYmUiLCJyb2xlIjoiU3R1ZGVudCIsIm5iZiI6MTY5Mzg5NzY2MiwiZXhwIjoxNjk1MTA3MjYyLCJpYXQiOjE2OTM4OTc2NjJ9.SXLqNBjorebQl52QrIEgEhBq_7Cw92CiKuyFgkdzU2KWo8iLAoSva6jLTOJP70Ix1GsA8r69CRcmPZvgcqKpIg,
    isFreeTrial: true,
    freeTrialDate: 2023-09-08T00:06:14.8164996,
    isExist: true,
    isActive: true
  }
*/