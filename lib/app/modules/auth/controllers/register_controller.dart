import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/errors/error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/base_url.dart';
import '../models/register_model.dart';

class RegisterController extends AuthController {
  //image
  Rx<File?> storedImage = Rxn<File?>();
  //form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController stageController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  // loadings
  final RxBool isLoadingSections = false.obs;
  final RxBool isLoadingStages = false.obs;
  final RxBool isLoadingGrades = false.obs;
  //data
  final List<Register> sections = [];
  final List<Register> stages = [];
  final List<Register> grades = [];
  String? sectionId;
  String? stageId;
  String? gradeId;

  @override
  onInit() {
    if (selectedCountry != null) {
      getSections();
      getStages();
    }
    super.onInit();
  }

  Future<void> getSections() async {
    isLoadingSections.value = true;
    final url =
        ('${baseUrl}Section/GetSections?countryId=${selectedCountry!.id}');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${authData.token}",
    };
    sections.addAll(await _getRegisterData(headers, url, "section"));

    isLoadingSections.value = false;
  }

  Future<void> getStages() async {
    isLoadingStages.value = true;

    final url = ('${baseUrl}Stage/GetStages?countryId=${selectedCountry!.id}');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${authData.token}",
    };
    stages.addAll(await _getRegisterData(headers, url, "stage"));
    isLoadingStages.value = false;
  }

  Future<void> getGrades() async {
    isLoadingGrades.value = true;
    grades.clear();
    final url = ('${baseUrl}Grade/GetGradesByStageId/$stageId');
    Map<String, String> headers = {
      "Authorization": "Bearer ${authData.token}",
      "Content-Type": "application/json",
    };
    grades.addAll(await _getRegisterData(headers, url, "grade"));

    isLoadingGrades.value = false;
  }

  Future<List<Register>> _getRegisterData(
      Map<String, String> headers, url, String registerType) async {
    try {
      final response =
          await dio.Dio().get(url, options: dio.Options(headers: headers));
      final List<Register> registerList = [];
      for (final register in response.data) {
        registerList.add(
          Register(
            name: register["${registerType}Name"],
            id: register["${registerType}Id"],
          ),
        );
      }
      return registerList;
    } catch (e) {
      Get.offAll(const ErrorScreen());
    }
    return [];
  }

  Future<void> register() async {
    try {
      if (!(formKey.currentState?.validate() ?? false)) {
        return;
      }
      Map<String, String> headers = {
        "Authorization": "Bearer ${authData.token}",
        "Content-Type": "multipart/form-data",
      };
      dio.MultipartFile? image = storedImage.value != null
          ? await dio.MultipartFile.fromFile(storedImage.value!.path.toString())
          : null;
      dio.FormData formData = dio.FormData.fromMap({
        "ProfileImage": image != null ? [image] : null,
        'Name': nameController.text,
        'NickName': nickNameController.text,
        'Email': emailController.text,
        'SectionId': sectionId ?? "",
        'StageId': stageId ?? "",
        'GradeId': gradeId,
      });
      const url = ('${baseUrl}Student/StudentRegistration');
      late final dio.Response response;
      response = await dio.Dio()
          .post(url, data: formData, options: dio.Options(headers: headers));

      if (response.statusCode == 200) {
        final pref = await SharedPreferences.getInstance();
        pref.setBool("isLogin", true);
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      Get.offAll(const ErrorScreen());
    }
  }
}
