import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../../core/shared/errors/error_screen.dart';
import '../../../../data/models/student.dart';
import '../../../../data/models/user.dart';
import '../../../main/controllers/main_controller.dart';
import '../../../../core/constants/base_url.dart';
import '../../../../core/functions/get_student_profile.dart';

class StudentHomeController extends MainController {
  Student? currentStudent;
  final MainController mainController = Get.find<MainController>();
  late User currentUser;

  Future<void> getUser(studentOrToken) async {
    if (studentOrToken is Student) {
      currentStudent = studentOrToken;
    } else if (studentOrToken is String) {
      currentStudent = await getStudentProfile(studentOrToken);
      mainController.user = User(
        userId: currentStudent!.studentId,
        token: mainController.user.token,
        userName: currentStudent!.name,
        userEmail: currentStudent!.email,
        userImage: currentStudent!.profileImage,
        isLogin: true,
        isTeacher: false,
        isVisitor: false,
      )..setData();
    }
    currentUser = mainController.user;
  }

  Future<void> qrLogin(String barCode) async {
    try {
      final body = json.encode({"userId": currentUser.userId, "qr": barCode});
      Uri url = Uri.parse("${baseUrl}Student/QrLogin");
      Map<String, String> head = {"Content-Type": "application/json"};

      await post(url, body: body, headers: head);

      Get.back();
    } catch (e) {
      Get.offAll(() => const ErrorScreen());
    }
  }
}