import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../../core/constants/base_url.dart';
import '../../../../core/functions/get_student_profile.dart';
import '../../../../core/shared/errors/error_screen.dart';
import '../../../../data/models/library.dart';
import '../../../../data/models/student.dart';
import '../../../../data/models/subject.dart';
import '../../../../data/models/user.dart';
import '../../../main/controllers/main_controller.dart';

class StudentHomeController extends MainController {
  RxBool isSearching = false.obs;
  Student? currentStudent;
  final MainController mainController = Get.find<MainController>();

  late User currentUser;

  List<Subject> subjects = [];
  List<Library> libraries = [];

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
    await getSub();
    await getLib();
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

  Future<void> getLib() async {
    if (libraries.isNotEmpty) return;
    try {
      Uri url = Uri.parse("${baseUrl}MainCategory/GetMainCategoriesForStudent");

      Map<String, String> head = {
        "Authorization": "Bearer ${currentUser.token}",
        "Content-Type": "application/json",
      };

      final response = await get(url, headers: head);

      List<dynamic> libs = json.decode(response.body);

      for (final lib in libs) {
        libraries.add(Library.fromJson(lib));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSub() async {
    if (subjects.isNotEmpty) return;
    try {
      Uri url =
          Uri.parse("${baseUrl}StudentSubscription/GetAllSubjectsForStudent");
      Map<String, String> head = {
        "Authorization": "Bearer ${currentUser.token}"
      };

      final response = await get(url, headers: head);

      List<dynamic> subs = json.decode(response.body);
      for (final sub in subs) {
        subjects.add(Subject.fromJson(sub));
      }
    } catch (e) {
      print(e);
    }
  }
}
