// TODO: add password fields and add a default password field
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/state_management/auth_controller.dart';

import '../../../../../shared/styles/text_field_styles.dart';

class ResetPassword extends GetView<AuthController> {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        child: Column(
          key: controller.teacherResetPassFromKey,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: controller.resetCodeController,
                decoration: authInputDecoration(labelText: "البريد الالكتروني")
                    .copyWith(
                  prefixIcon: const Icon(Icons.code),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
