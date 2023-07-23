import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_egabat/app/modules/auth/controllers/auth_controller.dart';
import 'package:my_egabat/app/modules/main/controllers/main_controller.dart';
import 'package:my_egabat/app/shared/errors/error_screen.dart';

import '../../../shared/base_url.dart';
import '../models/grade_model.dart';
import '../models/section_model.dart';
import '../models/stage_model.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final MainController mainController = Get.find<MainController>();
  TextEditingController sectionController = TextEditingController();
  TextEditingController stageController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  final RxBool isLoadingSections = false.obs;
  List<Section> sections = [];
  List<Stage> stages = [];
  List<Grade> grades = [];
  String? sectionId;
  String? stageId;
  String? gradeId;

  @override
  onInit() {
    getSections();
    super.onInit();
  }

  Future<void> getSections() async {
    isLoadingSections.value = true;
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${mainController.authData.token}",
      };
      final AuthController authController = Get.find<AuthController>();
      final Uri uri = Uri.parse(
          '${baseUrl}Section/GetSections?countryId=${authController.selectedCountry!.id}');
      final response = await http.get(uri, headers: headers);
      final List sectionsData = json.decode(response.body);

      for (var section in sectionsData) {
        sections.add(
            Section(name: section["sectionName"], id: section["sectionId"]));
      }
    } catch (e) {
      Get.offAll(const ErrorScreen());
    }
    isLoadingSections.value = false;
  }

  Future<void> getStages() async {
    Map<String, String> headers = {
      "Authorization": "Bearer ${mainController.authData.token}",
      "Content-Type": "multipart/form-data",
    };
  }

  Future<void> getGrades() async {
    Map<String, String> headers = {
      "Authorization": "Bearer ${mainController.authData.token}",
      "Content-Type": "multipart/form-data",
    };
    final Uri uri = Uri.parse('${baseUrl}Grade/GetGradesByStageId/$stageId');
    final response = await http.get(uri, headers: headers);

    print(response.body);
  }

  Future<void> register() async {
    Map<String, String> headers = {
      "Authorization": "Bearer ${mainController.authData.token}",
      "Content-Type": "multipart/form-data",
    };
    print("called from register controller");
  }
}
