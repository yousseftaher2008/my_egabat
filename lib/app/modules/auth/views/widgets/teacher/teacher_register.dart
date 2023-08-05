import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/register_controller.dart';
import 'package:my_egabat/app/modules/auth/views/widgets/shared/phone_country_input.dart';
import 'package:my_egabat/app/modules/auth/views/widgets/shared/register_educational_information.dart';
import 'package:my_egabat/app/shared/styles/button_styles.dart';

import '../shared/register_personal_information.dart';

class TeacherRegister extends GetView<RegisterController> {
  const TeacherRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
            () => controller.isFirstRegisterStep.value
                ? const PhoneCountryInput()
                : const RegisterEducationalInformation(isTeacher: true),
          ),
          Obx(
            () => (controller.isFirstRegisterStep.value)
                ? const RegisterPersonalInformation(
                    isTeacher: true,
                  )
                : const SizedBox(),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isFirstRegisterStep.value
                  ? controller.nextRegisterStep
                  : controller.teacherRegister,
              style: primaryButtonStyle,
              child: Text(
                controller.isFirstRegisterStep.value
                    ? "التالي"
                    : "انشاء حساب جديد",
              ),
            ),
          )
        ],
      ),
    );
  }
}
