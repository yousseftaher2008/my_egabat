import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_data.dart';

class MainController extends GetxController {
  late AuthData _authData;

  @override
  onReady() {
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
}
