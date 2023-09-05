class User {
  final String id, token, userName, userEmail, userImage;

  final bool isLogin, isVisitor, isTeacher;

  User({
    required this.id,
    required this.token,
    required this.userName,
    required this.userEmail,
    required this.userImage,
    required this.isLogin,
    required this.isTeacher,
    required this.isVisitor,
  });
}
