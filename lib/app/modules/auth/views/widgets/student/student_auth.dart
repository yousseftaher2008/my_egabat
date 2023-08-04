import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../shared/styles/button_styles.dart';
import '../../../controllers/auth_controller.dart';
import '../shared/phone_country_input.dart';
import '../shared/register_educational_information.dart';
import '../shared/register_personal_information.dart';

class StudentAuth extends GetView<AuthController> {
  const StudentAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final double pageHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SizedBox(
      height: pageHeight * 0.5,
      child: SingleChildScrollView(
        child: Obx(
          () => Container(
            constraints: BoxConstraints(minHeight: pageHeight * 0.5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                controller.registerController.isRegister.value
                    ? controller.registerController.isFirstRegisterStep.value
                        ? const RegisterPersonalInformation()
                        : const RegisterEducationalInformation()
                    : PhoneCountryInput(onSaved: controller.studentLogin),
                SizedBox(
                  child: ElevatedButton(
                    style: primaryButtonStyle,
                    onPressed: controller.registerController.isRegister.value
                        ? controller
                                .registerController.isFirstRegisterStep.value
                            ? controller.registerController.nextRegisterStep
                            : controller.registerController.studentRegister
                        : controller.studentLogin,
                    child: Text(
                      controller.registerController.isRegister.value
                          ? controller
                                  .registerController.isFirstRegisterStep.value
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
      ),
    );
  }
}
