import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/register_controller.dart';
import 'package:my_egabat/app/modules/auth/views/widgets/teacher/teacher_login.dart';
import 'package:my_egabat/app/modules/auth/views/widgets/teacher/teacher_register.dart';

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
