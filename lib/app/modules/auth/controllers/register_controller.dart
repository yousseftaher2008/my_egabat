import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/errors/error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/base_url.dart';
import '../models/register_model.dart';

class RegisterController extends AuthController {
  //image
  Rx<File?> storedImage = Rxn<File?>();
  //controllers
  final AuthController authController = Get.find<AuthController>();
  //form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //Student TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController studentEmailController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController stageController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  // loadings
  final RxBool isLoadingSections = false.obs;
  final RxBool isLoadingStages = false.obs;
  final RxBool isLoadingGrades = false.obs;
  final RxBool isLoadingSubjects = false.obs;
  //ui transitions data
  final RxBool isRegister = false.obs;
  final RxBool isFirstRegisterStep = false.obs;
  //data
  final List<Register> sections = [];
  final List<Register> stages = [];
  final List<Register> grades = [];
  final List<Register> subjects = [];
  String? sectionId;
  String? stageId;
  String? gradeId;
  String? subjectsId;

  Future<void> getSections() async {
    if (sections.isNotEmpty) {
      return;
    }
    isLoadingSections.value = true;
    final url =
        ('${baseUrl}Section/GetSections?countryId=${authController.selectedCountry?.id}');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${authData.token}",
    };
    sections.addAll(await _getRegisterData(headers, url, "section"));

    isLoadingSections.value = false;
  }

  Future<void> getStages() async {
    if (stages.isNotEmpty) {
      return;
    }
    isLoadingStages.value = true;

    final url =
        ('${baseUrl}Stage/GetStages?countryId=${authController.selectedCountry?.id}');
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

  Future<void> getSubjects() async {
    if (sectionId == null || gradeId == null) {
      return;
    }
    subjects.clear();
    isLoadingSubjects.value = true;
    final url =
        '${baseUrl}Subject/GetSubjectsByGradeAndSection?SectionId=$sectionId&GradeId=$gradeId';
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    subjects.addAll(await _getRegisterData(headers, url, "subject"));
    isLoadingSubjects.value = false;
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
      print(e);
      Get.offAll(() => const ErrorScreen());
    }
    return [];
  }

  Future<void> studentRegister() async {
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
        'Email': studentEmailController.text,
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
      Get.offAll(() => const ErrorScreen());
    }
  }

  Future<void> teacherRegister() async {
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
        'Email': studentEmailController.text,
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
    } catch (e) {}
  }

  Future<void> takePicture(
    ImageSource source,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (photo != null) {
      final File imageFile = File(photo.path);

      Get.find<RegisterController>().storedImage.value = imageFile;
    }
  }

  Future<void> nextRegisterStep() async {
    if (!isRegister.value) {
      isFirstRegisterStep.value = true;
      isRegister.value = true;
    } else {
      await authController.isValidPhone();
      if (!(formKey.currentState?.validate() ?? false) ||
          !(authController.phoneKey.currentState?.validate() ?? false)) {
        return;
      }
      isFirstRegisterStep.value = false;
    }
  }

  void backFromRegister() {
    // back to register page
    if (isFirstRegisterStep.value) {
      isRegister.value = false;
      isFirstRegisterStep.value = false;
      clearFirstPageInputs();
    } else {
      clearSecondPageInputs();
      isFirstRegisterStep.value = true;
    }
  }

  void clearFirstPageInputs() {
    storedImage.value = null;
    nameController.clear();
    nickNameController.clear();
    studentEmailController.clear();
  }

  void clearSecondPageInputs() {
    sections.clear();
    stages.clear();
    grades.clear();
    sectionController.clear();
    stageController.clear();
    gradeController.clear();
  }
}
