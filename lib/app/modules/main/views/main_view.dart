import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/bindings/auth_binding.dart';
import 'package:my_egabat/app/modules/home/bindings/home_binding.dart';
import '../../welcome/bindings/welcome_binding.dart';
import '../../welcome/views/welcome_view.dart';
import '../../../shared/errors/error_screen.dart';
import '../../../shared/errors/no_internet_screen.dart';
import '../../../shared/loading/lottie_loading.dart';
import '../../auth/views/screens/auth_view.dart';
import '../../home/views/screens/home_view.dart';
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

              if (futureConnection.hasData) {
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
                      HomeBinding().dependencies();
                      return const HomeView();
                    } else {
                      AuthBinding().dependencies();
                      return const AuthView();
                    }
                  },
                );
              }
              return LargeLottieLoading();
            }),
      );
    } catch (e) {
      return const ErrorScreen();
    }
  }
}
