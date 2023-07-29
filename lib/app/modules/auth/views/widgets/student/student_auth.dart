import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../shared/styles/button_styles.dart';
import '../../../controllers/auth_controller.dart';
import '../shared/phone_country_input.dart';
import '../student/register_educational_information.dart';
import '../shared/register_personal_information.dart';

class StudentAuth extends GetView<AuthController> {
  const StudentAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            controller.isRegister.value
                ? controller.isFirstRegisterStep.value
                    ? const RegisterPersonalInformation()
                    : const RegisterEducationalInformation()
                : PhoneCountryInput(Get.find<AuthController>()),
            SizedBox(
              child: ElevatedButton(
                style: primaryButtonStyle,
                onPressed: controller.isRegister.value
                    ? controller.isFirstRegisterStep.value
                        ? controller.nextRegisterStep
                        : controller.registerController?.register
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
    );
  }
}
