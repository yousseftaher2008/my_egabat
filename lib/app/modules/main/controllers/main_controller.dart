import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/errors/no_internet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_data.dart';

class MainController extends GetxController {
  late AuthData _authData;
  late StreamSubscription connectionStream;
  RxBool isLoading = true.obs;

  bool isWelcomeViewed = false;
  @override
  Future<void> onReady() async {
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
    getAuthData().then((AuthData authData) => _authData = authData);
    super.onReady();
  }

  Future<bool> isAuth() async {
    _authData = await getAuthData();
    return _authData.isLogin && _authData.token.isNotEmpty;
  }

  Future<AuthData> getAuthData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String token = pref.getString('token') ?? "";
    final String teacherName = pref.getString('TeacherName') ?? "";
    final String userId = pref.getString('id') ?? "";
    final bool isLogin = pref.getBool('isLogin') ?? false;
    final bool isVisitor = pref.getBool('isVisitingTeacher') ?? false;

    AuthData authData = AuthData(
      token: token,
      teacherName: teacherName,
      id: userId,
      isLogin: isLogin,
      isVisitor: isVisitor,
    );
    return authData;
  }

  Future<bool> isConnected() async {
    var result = await Connectivity().checkConnectivity();
    return result.name != "none";
  }

  Future<void> getIsWelcomeViewed() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isWelcomeViewed = pref.getBool("isViewed") ?? false;
  }
}
