// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/core/services/services.dart';
import '../../../routes/app_pages.dart';
import '../../../core/shared/errors/no_internet_screen.dart';

import '../../../data/models/user.dart';

class MainController extends GetxController {
  late User user;
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
    return user.isLogin && user.token.isNotEmpty;
  }

  Future<void> getAuthData() async {
    final String token = appServices.pref.getString('token') ?? "";
    final String userName = appServices.pref.getString('userName') ?? "";
    final String userEmail = appServices.pref.getString('userEmail') ?? "";
    final String userImage = appServices.pref.getString('userImage') ?? "";
    final String userId = appServices.pref.getString('userId') ?? "";
    final bool isLogin = appServices.pref.getBool('isLogin') ?? false;
    final bool isTeacher = appServices.pref.getBool('isTeacher') ?? false;
    final bool isVisitor =
        appServices.pref.getBool('isVisitingTeacher') ?? false;

    user = User(
      id: userId,
      token: token,
      userName: userName,
      userEmail: userEmail,
      userImage: userImage,
      isLogin: isLogin,
      isTeacher: isTeacher,
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
