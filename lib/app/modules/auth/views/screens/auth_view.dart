import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:my_egabat/app/modules/auth/views/widgets/auth_card.dart';
import '../../../../shared/styles/button_styles.dart';
import '../../../../shared/styles/colors.dart';

import '../../controllers/auth_controller.dart';
import '../widgets/register.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double pageHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: pageHeight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: ColoredBox(
                    color: primaryColor,
                    child: SizedBox(
                      height: pageHeight / 3,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Obx(() => Image.asset(controller.isRegister.value
                            ? "assets/register_image.png"
                            : "assets/login_image.png")),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: pageHeight - (pageHeight / 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      controller.isRegister.value
                          ? const Register()
                          : const AuthCard(),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: primaryButtonStyle,
                          onPressed: controller.login,
                          child: const Text("Login"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
