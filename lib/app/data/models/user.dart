import 'package:get/get.dart';
import 'package:my_egabat/app/core/services/services.dart';

class User {
  String? userId, token, userName, userEmail, userImage;
  bool? isLogin, isVisitor, isTeacher;

  final AppServices _appServices = Get.find<AppServices>();
  User({
    required this.userId,
    this.token,
    required this.userName,
    required this.userEmail,
    required this.userImage,
    required this.isLogin,
    required this.isTeacher,
    required this.isVisitor,
  });

  Future<void> setData() async {
    await _appServices.pref.setString("token", token ?? "");
    await _appServices.pref.setString("userId", userId ?? "");
    await _appServices.pref.setString("userName", userName ?? "");
    await _appServices.pref.setString("userEmail", userEmail ?? "");
    await _appServices.pref.setString("userImage", userImage ?? "");
    await _appServices.pref.setBool("isTeacher", isTeacher ?? false);
    await _appServices.pref.setBool("isVisitingTeacher", isVisitor ?? false);
    await _appServices.pref.setBool("isLogin", isLogin ?? false);
  }

  User.fromPref() {
    token = _appServices.pref.getString('token');
    userName = _appServices.pref.getString('userName');
    userEmail = _appServices.pref.getString('userEmail');
    userImage = _appServices.pref.getString('userImage');
    userId = _appServices.pref.getString('userId');
    isLogin = _appServices.pref.getBool('isLogin');
    isTeacher = _appServices.pref.getBool('isTeacher');
    isVisitor = _appServices.pref.getBool('isVisitingTeacher');
  }
}
