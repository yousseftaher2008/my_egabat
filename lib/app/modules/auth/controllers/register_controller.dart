import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'auth_controller.dart';
import '../../main/controllers/main_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/errors/error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/base_url.dart';
import '../models/register_model.dart';

class RegisterController extends GetxController {
  //image
  Rx<File?> storedImage = Rxn<File?>();
  // controllers
  final MainController mainController = Get.find<MainController>();
  final AuthController authController = Get.find<AuthController>();
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
    getSections();
    getStages();
    super.onInit();
  }

  Future<void> getSections() async {
    isLoadingSections.value = true;
    final Uri uri = Uri.parse(
        '${baseUrl}Section/GetSections?countryId=${authController.selectedCountry!.id}');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${mainController.authData.token}",
    };
    sections.addAll(await _getRegisterData(headers, uri, "section"));

    isLoadingSections.value = false;
  }

  Future<void> getStages() async {
    isLoadingStages.value = true;

    final Uri uri = Uri.parse(
        '${baseUrl}Stage/GetStages?countryId=${authController.selectedCountry!.id}');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${mainController.authData.token}",
    };
    stages.addAll(await _getRegisterData(headers, uri, "stage"));
    isLoadingStages.value = false;
  }

  Future<void> getGrades() async {
    isLoadingGrades.value = true;
    grades.clear();
    final Uri uri = Uri.parse('${baseUrl}Grade/GetGradesByStageId/$stageId');
    Map<String, String> headers = {
      "Authorization": "Bearer ${mainController.authData.token}",
      "Content-Type": "application/json",
    };
    grades.addAll(await _getRegisterData(headers, uri, "grade"));

    isLoadingGrades.value = false;
  }

  Future<List<Register>> _getRegisterData(
      Map<String, String> headers, Uri uri, String registerType) async {
    try {
      final response =
          await dio.Dio().getUri(uri, options: dio.Options(headers: headers));
      final List registerData = json.decode(response.data);
      final List<Register> registerList = [];
      for (final register in registerData) {
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
        "Authorization": "Bearer ${mainController.authData.token}",
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
      final Uri uri = Uri.parse('${baseUrl}Student/StudentRegistration');
      late final dio.Response response;
      response = await dio.Dio()
          .postUri(uri, data: formData, options: dio.Options(headers: headers));

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
