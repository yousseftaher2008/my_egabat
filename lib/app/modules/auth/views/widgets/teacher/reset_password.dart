// TODO: add password fields and add a default password field
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/state_management/auth_controller.dart';
import 'package:my_egabat/app/shared/widgets/password_field.dart';

import '../../../../../shared/styles/text_field_styles.dart';

class ResetPassword extends GetView<AuthController> {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: controller.teacherResetPassFromKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: controller.resetCodeController,
                decoration:
                    authInputDecoration(labelText: "الكود الذي ارسل اليك")
                        .copyWith(
                  prefixIcon: const Icon(Icons.code),
                ),
              ),
            ),
            AppPasswordField(
              controller.teacherResetPassController,
              onFieldSubmitted: (_) => null,
            ),
            AppPasswordField(
              controller.teacherResetPassController2,
              onFieldSubmitted: (_) =>
                  controller.teacherResetPassFromKey.currentState!.validate(),
              hintText: "رمز المرور مرة اخرى",
              moreValidating: () {
                return controller.teacherResetPassController.text !=
                        controller.teacherResetPassController2.text
                    ? "الرمزان غير متطابقان"
                    : null;
              },
            )
          ],
        ),
      ),
    );
  }
}
