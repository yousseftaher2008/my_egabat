import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:my_egabat/app/modules/auth/views/widgets/register_educational_information.dart';
import '../widgets/auth_card.dart';
import '../../../../shared/styles/button_styles.dart';
import '../../../../shared/styles/colors.dart';

import '../../controllers/auth_controller.dart';
import '../widgets/register_personal_information.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double pageHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: pageHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipPath(
                      clipper: OvalBottomBorderClipper(),
                      child: Container(
                        color: primaryColor,
                        height: pageHeight / 3,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Obx(
                            () => Image.asset(
                              controller.isRegister.value
                                  ? "assets/register_image.png"
                                  : "assets/login_image.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            controller.isRegister.value
                                ? controller.isFirstRegisterStep.value
                                    ? const RegisterPersonalInformation()
                                    : const RegisterEducationalInformation()
                                : const AuthCard(),
                            SizedBox(
                              child: ElevatedButton(
                                style: primaryButtonStyle,
                                onPressed: controller.isRegister.value
                                    ? controller.isFirstRegisterStep.value
                                        ? controller.nextRegisterStep
                                        : controller
                                            .registerController?.register
                                    : controller.login,
                                child: Text(
                                  controller.isRegister.value
                                      ? controller.isFirstRegisterStep.value
                                          ? "التالي"
                                          : "تسجيل حساب جديد"
                                      : "تسجيل الدخول",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.isRegister.value
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: controller.backFromRegister,
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
