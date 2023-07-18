import 'package:flutter/material.dart';

import "package:connectivity_plus/connectivity_plus.dart";
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/views/screens/auth_view.dart';
import 'package:my_egabat/app/modules/home/views/screens/home_view.dart';
import '../../../shared/errors/error_screen.dart';
import '../../../shared/errors/no_internet_screen.dart';
import '../../../shared/loading/lottie_loading.dart';
import '../controllers/main_controller.dart';
// todo: correct connection error

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  Future<bool> _isConnected() async {
    var result = await Connectivity().checkConnectivity();
    return result.name != "none";
  }

  @override
  Widget build(BuildContext context) {
    try {
      return FutureBuilder<bool>(
          future: _isConnected(),
          builder: (context, futureConnection) {
            if (futureConnection.data == false) {
              return const NoInternetScreen();
            }
            return StreamBuilder<ConnectivityResult>(
                stream: Connectivity().onConnectivityChanged,
                builder: (context, streamConnection) {
                  if (streamConnection.data == ConnectivityResult.none) {
                    return const NoInternetScreen();
                  }
                  return FutureBuilder(
                    future: controller.isAuth(),
                    builder: (context, isAuth) {
                      if (isAuth.connectionState == ConnectionState.waiting ||
                          futureConnection.connectionState ==
                              ConnectionState.waiting ||
                          streamConnection.connectionState ==
                              ConnectionState.waiting) {
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
                });
          });
    } catch (e) {
      return const ErrorScreen();
    }
  }
}
