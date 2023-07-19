import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../welcome/bindings/welcome_binding.dart';
import '../../welcome/views/welcome_view.dart';
import '../../../shared/errors/error_screen.dart';
import '../../../shared/errors/no_internet_screen.dart';
import '../../../shared/loading/lottie_loading.dart';
import '../../auth/views/screens/auth_view.dart';
import '../../home/views/screens/home_view.dart';
import '../controllers/main_controller.dart';

// todo: correct connection error
class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Obx(
        () => controller.isLoading.value
            ? Scaffold(body: LargeLottieLoading())
            : FutureBuilder<bool>(
                future: controller.isConnected(),
                builder: (context, futureConnection) {
                  if (futureConnection.connectionState ==
                      ConnectionState.waiting) {
                    return Scaffold(body: LargeLottieLoading());
                  }
                  if (futureConnection.data == false) {
                    return const NoInternetScreen();
                  }
                  if (!controller.isWelcomeViewed) {
                    WelcomeBinding().dependencies();
                    return const WelcomeView();
                  }
                  return FutureBuilder(
                    future: controller.isAuth(),
                    builder: (context, isAuth) {
                      if (isAuth.connectionState == ConnectionState.waiting) {
                        return Scaffold(body: LargeLottieLoading());
                      }
                      if (isAuth.hasError) {
                        return const ErrorScreen();
                      }

                      if (isAuth.data ?? false) {
                        return const HomeView();
                      } else {
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
