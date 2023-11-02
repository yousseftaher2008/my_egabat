import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/state_management/register_controller.dart';
import 'teacher_login.dart';
import 'teacher_register.dart';

class TeacherAuth extends GetView<RegisterController> {
  const TeacherAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => controller.isRegister.value
            ? const TeacherRegister()
            : const TeacherLogin(),
      ),
    );
  }
}
