import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/home/student_home/bindings/student_home_binding.dart';
import 'package:my_egabat/app/modules/home/student_home/views/student_home_view.dart';
import 'package:my_egabat/app/modules/home/teacher/teacher_home/bindings/teacher_home_binding.dart';
import 'package:my_egabat/app/modules/home/teacher/teacher_home/views/teacher_home_view.dart';

import '../../auth/bindings/auth_binding.dart';
import '../../auth/views/screens/auth_view.dart';
import '../../home/teacher/visitor_home/bindings/visitor_home_binding.dart';
import '../../home/teacher/visitor_home/views/visitor_home_view.dart';
import '../../welcome/bindings/welcome_binding.dart';
import '../../welcome/views/welcome_view.dart';
import '../../../core/shared/errors/error_screen.dart';
import '../../../core/shared/errors/no_internet_screen.dart';
import '../../../core/constants/loading/lottie_loading.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        body: FutureBuilder<bool>(
            future: controller.isConnected(),
            builder: (context, futureConnection) {
              if (futureConnection.connectionState == ConnectionState.waiting) {
                return LargeLottieLoading();
              }

              if (futureConnection.hasError) {
                return const ErrorScreen();
              }

              if (!futureConnection.hasData) {
                return LargeLottieLoading();
              }

              if (futureConnection.data == false) {
                return const NoInternetScreen();
              }

              if (controller.isLoading.value) {
                return LargeLottieLoading();
              }

              if (!controller.isWelcomeViewed) {
                WelcomeBinding().dependencies();
                return const WelcomeView();
              }

              return FutureBuilder(
                future: controller.isAuth(),
                builder: (context, isAuth) {
                  if (isAuth.connectionState == ConnectionState.waiting) {
                    return LargeLottieLoading();
                  }

                  if (isAuth.hasError) {
                    return const ErrorScreen();
                  }

                  if (isAuth.data ?? false) {
                    if (controller.user.isTeacher) {
                      TeacherHomeBinding().dependencies();
                      return const TeacherHomeView();
                    } else if (controller.user.isVisitor) {
                      VisitorHomeBinding().dependencies();
                      return const VisitorHomeView();
                    } else {
                      StudentHomeBinding().dependencies();
                      return const StudentHomeView();
                    }
                  } else {
                    AuthBinding().dependencies();
                    return const AuthView();
                  }
                },
              );
            }),
      );
    } catch (e) {
      return const ErrorScreen();
    }
  }
}
