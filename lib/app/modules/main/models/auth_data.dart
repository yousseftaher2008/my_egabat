class AuthData {
  final String token, teacherName, id;

  final bool isLogin, isVisitor;

  AuthData({
    required this.token,
    required this.teacherName,
    required this.id,
    required this.isLogin,
    required this.isVisitor,
  });
}
