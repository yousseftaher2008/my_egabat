import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/screens/auth_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/home/student_home/bindings/student_home_binding.dart';
import '../modules/home/student_home/views/student_home_view.dart';
import '../modules/home/teacher/teacher_home/bindings/teacher_home_binding.dart';
import '../modules/home/teacher/teacher_home/views/teacher_home_view.dart';
import '../modules/home/teacher/visitor_home/bindings/visitor_home_binding.dart';
import '../modules/home/teacher/visitor_home/views/visitor_home_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_HOME,
      page: () => const TeacherHomeView(),
      binding: TeacherHomeBinding(),
    ),
    GetPage(
      name: _Paths.VISITOR_HOME,
      page: () => const VisitorHomeView(),
      binding: VisitorHomeBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_HOME,
      page: () => const StudentHomeView(),
      binding: StudentHomeBinding(),
    ),
  ];
}
