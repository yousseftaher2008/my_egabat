import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/loading/lottie_loading.dart';
import '../../../../../core/constants/styles/button_styles.dart';
import '../../../../../core/shared/widgets/email_field.dart';
import '../../../../../core/shared/widgets/password_field.dart';
import '../../../controllers/state_management/auth_controller.dart';

class TeacherLogin extends GetView<AuthController> {
  const TeacherLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Form(
          key: controller.teacherFromKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppEmailField(
                controller.teacherEmailController,
                textInputAction: TextInputAction.next,
              ),
              AppPasswordField(
                controller.teacherPassController,
                onFieldSubmitted: (_) => controller.teacherLogin(),
              )
            ],
          ),
        ),
        Column(
          children: [
            Obx(
              () => controller.isLogging.value
                  ? SmallLottieLoading()
                  : ElevatedButton(
                      style: primaryButtonStyle,
                      onPressed: controller.teacherLogin,
                      child: Text("تسجيل الدخول".tr),
                    ),
            ),
            TextButton(
              onPressed: controller.registerController.nextRegisterStep,
              child: Text(
                "تسجيل كمعلم زائر".tr,
              ),
            ),
          ],
        )
      ],
    );
  }
}
