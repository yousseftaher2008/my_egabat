import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/base_url.dart';
import '../../../../core/constants/styles/colors.dart';
import '../../../../core/shared/errors/error_screen.dart';
import '../../../../data/models/student.dart';
import '../../../../data/models/user.dart';
import '../../../../routes/app_pages.dart';
import '../../models/register_model.dart';
import '../../models/subject_model.dart';
import '../ui/register_edu_controller.dart';
import 'auth_controller.dart';

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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController stageController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  //conditions
  bool isEduContInitial = false;
  // loadings
  final RxBool isLoadingSection = false.obs;
  final RxBool isLoadingStage = false.obs;
  final RxBool isLoadingGrade = false.obs;
  final RxBool isLoadingSubject = false.obs;
  //ui transitions data
  final RxBool isRegister = false.obs;
  final RxBool isRegistering = false.obs;
  final RxBool isFirstRegisterStep = false.obs;
  //data
  final List sections = [];
  final List stages = [];
  final List grades = [];
  final List subjects = [];
  final Map<String, AuthSubject> selectedSubjects = {};
  RxInt selectedSubjectsLength = 0.obs;
  String? sectionId;
  String? stageId;
  String? gradeId;

  RxBool isSnackBarOpen = false.obs;

  Future<void> getSections() async {
    if (sections.isNotEmpty) {
      return;
    }
    isLoadingSection.value = true;
    final url =
        ('${baseUrl}Section/GetSections?countryId=${authController.selectedCountry?.id}');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${authController.user.token}",
    };
    sections.addAll(await _getRegisterData(headers, url, "section"));
    isLoadingSection.value = false;
  }

  Future<void> getStages() async {
    if (stages.isNotEmpty) {
      return;
    }
    isLoadingStage.value = true;
    final url =
        ('${baseUrl}Stage/GetStages?countryId=${authController.selectedCountry?.id}');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${authController.user.token}",
    };
    stages.addAll(await _getRegisterData(headers, url, "stage"));
    isLoadingStage.value = false;
  }

  Future<void> getGrades() async {
    isLoadingGrade.value = true;
    grades.clear();
    subjects.clear();
    //? to reload the subject ui
    isLoadingSubject.value = true;
    isLoadingSubject.value = false;

    final url = ('${baseUrl}Grade/GetGradesByStageId/$stageId');
    Map<String, String> headers = {
      "Authorization": "Bearer ${authController.user.token}",
      "Content-Type": "application/json",
    };
    grades.addAll(await _getRegisterData(headers, url, "grade"));
    isLoadingGrade.value = false;
  }

  Future<void> getSubjects() async {
    if ((sectionId?.isEmpty ?? true) || (gradeId?.isEmpty ?? true)) {
      return;
    }
    isLoadingSubject.value = true;
    subjects.clear();
    final url =
        '${baseUrl}Subject/GetSubjectsByGradeAndSection?SectionId=$sectionId&GradeId=$gradeId';
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    subjects.addAll((await _getRegisterData(headers, url, "subject", true)));
    isLoadingSubject.value = false;
  }

  Future<List> _getRegisterData(
      Map<String, String> headers, url, String registerType,
      [bool isSubject = false]) async {
    try {
      final response =
          await dio.Dio().get(url, options: dio.Options(headers: headers));

      final List registerList = [];
      for (final registerItem in response.data) {
        final Register newItem = isSubject
            ? AuthSubject.fromJson(registerItem)
            : Register(
                name: registerItem["${registerType}Name"],
                id: registerItem["${registerType}Id"],
              );
        registerList.add(newItem);
        isSubject
            ? (newItem as AuthSubject).isChosen.value =
                selectedSubjects.containsKey(newItem.id)
            : null;
      }
      return registerList;
    } catch (e) {
      Get.offAll(() => const ErrorScreen());
    }
    return [];
  }

  Future<void> studentRegister() async {
    isRegistering.value = true;
    try {
      if (!(formKey.currentState?.validate() ?? false)) {
        isRegistering.value = false;
        return;
      }

      print(mainController.user.token);
      Map<String, String> headers = {
        "Authorization": "Bearer ${mainController.user.token}",
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
      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        final Student student = Student.fromRegisterJson(response.data);
        mainController.user = User(
          userId: response.data["studentId"],
          token: mainController.user.token,
          userName: student.name,
          userEmail: student.email,
          userImage: student.profileImage,
          isLogin: true,
          isTeacher: false,
          isVisitor: false,
        )..setData();

        Get.offAllNamed(Routes.STUDENT_HOME, arguments: {
          "student": student,
        });
        return;
      }
    } catch (e) {
      isRegistering.value = false;
      print(e);
      Get.offAll(() => const ErrorScreen());
    }
  }

  Future<void> teacherRegister() async {
    isRegistering.value = true;
    try {
      if (!(formKey.currentState?.validate() ?? false) ||
          isSnackBarOpen.value) {
        isRegistering.value = false;
        return;
      }
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      final List<String> selectedSubjectsJson = [];
      selectedSubjects.forEach((key, value) {
        selectedSubjectsJson.add(value.id);
      });
      String body = json.encode({
        'name': nameController.text,
        'mobile': authController.phoneNumber,
        'email': emailController.text,
        'password': passwordController.text,
        'subjects': selectedSubjectsJson,
      });
      const String url = '${baseUrl}Teacher/RegisterVisitingTeacher';
      final response = await post(Uri.parse(url), body: body, headers: headers);
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          "تم انشاء الحساب بنجاح".tr,
          "يرجى التسجيل الان".tr,
          duration: const Duration(seconds: 2),
          backgroundColor: primaryButtonColor,
          colorText: Colors.white,
        );
        isRegistering.value = false;
        isRegister.value = false;
        clearFirstPageInputs();
        clearSecondPageInputs();
      } else {
        isSnackBarOpen.value = true;
        isRegistering.value = false;
        Get.snackbar(
          "حدث خطأ".tr,
          "${data["errors"]["Message"]}",
          duration: const Duration(seconds: 2),
          backgroundColor: primaryButtonColor,
          colorText: Colors.white,
        );
        Future.delayed(const Duration(seconds: 2), () {
          isSnackBarOpen.value = false;
        });
      }
    } catch (e) {
      isRegistering.value = false;
      Get.offAll(() => const ErrorScreen());
    }
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

      storedImage.value = imageFile;
    }
  }

  void updateSelectedSubjectsLength() =>
      selectedSubjectsLength.value = selectedSubjects.length;

  Future<void> nextRegisterStep() async {
    if (!isRegister.value) {
      isFirstRegisterStep.value = true;
      isRegister.value = true;
    } else {
      if (authController.isTeacher.value) {
        await authController.isValidPhone();
        if (!authController.phoneKey.currentState!.validate()) {
          formKey.currentState?.validate();
          return;
        }
      }
      if (!(formKey.currentState?.validate() ?? false)) {
        return;
      }

      Get.lazyPut(() => RegisterEduController(), fenix: true);
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
    emailController.clear();
    passwordController.clear();
  }

  void clearSecondPageInputs() {
    sections.clear();
    stages.clear();
    grades.clear();
    subjects.clear();
    selectedSubjects.clear();
    sectionController.clear();
    stageController.clear();
    gradeController.clear();
    sectionId = null;
    stageId = null;
    gradeId = null;
  }
}
