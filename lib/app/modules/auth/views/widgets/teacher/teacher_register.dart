import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/state_management/register_controller.dart';
import 'package:my_egabat/app/modules/auth/views/widgets/shared/phone_country_input.dart';
import 'package:my_egabat/app/modules/auth/views/widgets/shared/register_educational_information.dart';
import 'package:my_egabat/app/shared/styles/button_styles.dart';

import '../../../../../shared/loading/loading.dart';
import '../shared/register_personal_information.dart';

class TeacherRegister extends GetView<RegisterController> {
  const TeacherRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: controller.pageHeight * 0.5,
        child: SingleChildScrollView(
          child: Obx(
            () => Container(
              constraints:
                  BoxConstraints(minHeight: controller.pageHeight * 0.5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.isFirstRegisterStep.value
                      ? const PhoneCountryInput()
                      : const RegisterEducationalInfo(isTeacher: true),
                  (controller.isFirstRegisterStep.value)
                      ? const RegisterPersonalInfo(
                          isTeacher: true,
                        )
                      : const SizedBox(),
                  Obx(
                    () => controller.registerController.isRegistering.value
                        ? Loading()
                        : ElevatedButton(
                            onPressed: controller.isSnackBarOpen.value
                                ? null
                                : controller.isFirstRegisterStep.value
                                    ? controller.nextRegisterStep
                                    : controller.teacherRegister,
                            style: primaryButtonStyle,
                            child: Text(
                              controller.isFirstRegisterStep.value
                                  ? "التالي".tr
                                  : "تسجيل حساب جديد".tr,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
