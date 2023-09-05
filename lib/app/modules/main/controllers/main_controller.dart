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
    user = User.fromPref();
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
    super.onReady();
  }

  Future<bool> isAuth() async {
    return (user.isLogin ?? false) && (user.token?.isNotEmpty ?? false);
  }

  Future<bool> isConnected() async {
    var result = await Connectivity().checkConnectivity();
    return result.name != "none";
  }

  Future<void> getIsWelcomeViewed() async {
    isWelcomeViewed = appServices.pref.getBool("isWelcomeViewed") ?? false;
  }
}
