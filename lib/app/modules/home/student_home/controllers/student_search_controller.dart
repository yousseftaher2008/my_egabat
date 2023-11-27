import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/base_url.dart';
import '../../../../data/models/searched_subjects.dart';
import 'student_home_controller.dart';

class StudentSearchController extends StudentHomeController {
  StudentHomeController studentHomeController =
      Get.find<StudentHomeController>();
  final TextEditingController textEditingController = TextEditingController();
  final List<SearchedSubject> searchedSubjects = [];
  final RxInt searchedSubjectsLength = 0.obs;
  final RxBool isGettingData = false.obs;
  final RxBool isLastWasSubmit = false.obs;
  final RxBool isSubSearching = false.obs;
  final RxString searchedValue = "".obs;
  Future<void> getFiles(val) async {
    try {
      searchedSubjects.clear();

      isGettingData.value = true;
      final response = await http.get(
        Uri.parse("${baseUrl}Subject/GetAllAttachments?&Text=$val"),
        headers: {
          "Authorization": "Bearer ${studentHomeController.currentUser.token}",
        },
      );
      if (val != searchedValue.value) return;
      isGettingData.value = false;
      if (response.statusCode == 200) {
        searchedSubjects.clear();
        final List extractedData = json.decode(response.body);
        for (int i = 0; i < extractedData.length; i++) {
          searchedSubjects.add(
            SearchedSubject.fromJson(extractedData[i]),
          );
        }
        searchedSubjectsLength.value = searchedSubjects.length;
      }
    } catch (e) {
      print(e);
    }
  }

  void onValueChanged(String val, {bool must = false}) {
    searchedValue.value = val.trim();
    studentHomeController.isSearching.value = searchedValue.value.isNotEmpty;
    if (!must && val.length < 3) return;
    if (studentHomeController.isSearching.value) {
      getFiles(searchedValue.value);
    } else {
      searchedSubjects.clear();
      searchedSubjectsLength.value = 0;
      isGettingData.value = false;
    }
  }
}
