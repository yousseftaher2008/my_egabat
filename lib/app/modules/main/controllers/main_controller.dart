// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/core/services/services.dart';
import '../../../routes/app_pages.dart';
import '../../../core/shared/errors/no_internet_screen.dart';

import '../../../core/data/models/auth_data.dart';

class MainController extends GetxController {
  late AuthData authData;
  late StreamSubscription connectionStream;
  final double pageWidth = Get.size.width;
  final double pageHeight = Get.size.height;
  RxBool isLoading = true.obs;
  String? deviceToken;
  bool isWelcomeViewed = false;
  final AppServices appServices = Get.find<AppServices>();
  @override
  Future<void> onReady() async {
    final fbm = FirebaseMessaging.instance;
    deviceToken = await fbm.getToken();
    await getIsWelcomeViewed();
    connectionStream =
        Connectivity().onConnectivityChanged.listen((connection) {
      if (connection == ConnectivityResult.none) {
        Get.offAll(() => const NoInternetScreen());
      } else {
        Get.offAllNamed(Routes.MAIN);
      }
      isLoading.value = false;
    });
    getAuthData();
    super.onReady();
  }

  Future<bool> isAuth() async {
    await getAuthData();
    return authData.isLogin && authData.token.isNotEmpty;
  }

  Future<void> getAuthData() async {
    final String token = appServices.pref.getString('token') ?? "";
    final String teacherName = appServices.pref.getString('TeacherName') ?? "";
    final String userId = appServices.pref.getString('id') ?? "";
    final bool isLogin = appServices.pref.getBool('isLogin') ?? false;
    final bool isVisitor =
        appServices.pref.getBool('isVisitingTeacher') ?? false;

    authData = AuthData(
      token: token,
      teacherName: teacherName,
      id: userId,
      isLogin: isLogin,
      isVisitor: isVisitor,
    );
  }

  Future<bool> isConnected() async {
    var result = await Connectivity().checkConnectivity();
    return result.name != "none";
  }

  Future<void> getIsWelcomeViewed() async {
    isWelcomeViewed = appServices.pref.getBool("isViewed") ?? false;
    // isWelcomeViewed = false;
  }
}
