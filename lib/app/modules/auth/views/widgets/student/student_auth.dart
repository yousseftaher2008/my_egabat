import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/loading/lottie_loading.dart';
import '../../../../../core/constants/styles/button_styles.dart';
import '../../../controllers/state_management/auth_controller.dart';
import '../shared/phone_country_input.dart';
import '../shared/register_educational_information.dart';
import '../shared/register_personal_information.dart';

class StudentAuth extends GetView<AuthController> {
  const StudentAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: controller.pageHeight * 0.5,
      child: SingleChildScrollView(
        child: Obx(
          () => Container(
            constraints: BoxConstraints(minHeight: controller.pageHeight * 0.5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                controller.registerController.isRegister.value
                    ? controller.registerController.isFirstRegisterStep.value
                        ? const RegisterPersonalInfo()
                        : const RegisterEducationalInfo()
                    : PhoneCountryInput(onSaved: controller.studentLogin),
                controller.isLogging.value ||
                        controller.registerController.isRegistering.value
                    ? SmallLottieLoading()
                    : ElevatedButton(
                        style: primaryButtonStyle,
                        onPressed: controller
                                .registerController.isRegister.value
                            ? controller.registerController.isFirstRegisterStep
                                    .value
                                ? controller.registerController.nextRegisterStep
                                : controller.registerController.studentRegister
                            : controller.studentLogin,
                        child: Text(
                          controller.registerController.isRegister.value
                              ? controller.registerController
                                      .isFirstRegisterStep.value
                                  ? "التالي".tr
                                  : "تسجيل حساب جديد".tr
                              : "تسجيل الدخول".tr,
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
