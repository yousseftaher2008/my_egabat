import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/base_url.dart';

class TeacherController extends AuthController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isVisible = false.obs;

  @override
  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    formKey.currentState!.save();
    const String url = "${baseUrl}Teacher/Login";
    final body = dio.FormData.fromMap({
      "username": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "deviceToken": deviceToken,
    });
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'accept': "*/*",
    };
    try {
      final response = await dio.Dio()
          .get(url, data: body, options: dio.Options(headers: headers));
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', response.data["token"]);
      pref.setBool('isFreeTrial', response.data['isFreeTrial']);
      pref.setBool('isVisitingTeacher', response.data['isVisitingTeacher']);
      pref.setString('TeacherName', response.data["teacherName"]);
      // todo:
      // (response.data["isVisitingTeacher"] == true)
      // ? Go to(const VisitorTeacherHome())
      // : Go to(const HomeTeacher())
    } catch (e) {
      print(e);
    }

    // print(response.data);
  }

  void changeVisibility() {
    isVisible.value = !isVisible.value;
  }
}
