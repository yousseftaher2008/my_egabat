import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/views/widgets/teacher/teacher_login.dart';
import 'package:my_egabat/app/modules/auth/views/widgets/teacher/teacher_register.dart';
import '../../../bindings/teacher_binding.dart';
import '../../../controllers/teacher_controller.dart';

class TeacherAuth extends GetView<TeacherController> {
  const TeacherAuth({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherBinding().dependencies();
    return SingleChildScrollView(
      child: Obx(
        () => controller.isRegister.value
            ? const TeacherRegister()
            : const TeacherLogin(),
      ),
    );
  }
}
