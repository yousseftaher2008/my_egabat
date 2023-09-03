import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/shared/styles/button_styles.dart';

import '../../../controllers/state_management/reset_password_controller.dart';
import '../../../../../shared/widgets/password_field.dart';
import '../../../../../shared/styles/text_field_styles.dart';

class ResetPassword extends GetView<ResetPasswordController> {
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
                validator: (value) {
                  return (value?.isEmpty) ?? true
                      ? "ادخل الكود من فضلك"
                      : value != controller.expectedCode
                          ? "يرجى ادخال كود صحيح"
                          : null;
                },
              ),
            ),
            AppPasswordField(
              controller.teacherResetPassController,
              onFieldSubmitted: (_) => null,
            ),
            AppPasswordField(
              controller.teacherResetPassController2,
              onFieldSubmitted: (_) {
                controller.resetPassword();
              },
              hintText: "رمز المرور مرة اخرى",
              moreValidating: () {
                return controller.teacherResetPassController.text !=
                        controller.teacherResetPassController2.text
                    ? "الرمزان غير متطابقان"
                    : null;
              },
            ),
            ElevatedButton(
              style: primaryButtonStyle,
              onPressed: () {
                controller.resetPassword();
              },
              child: const Text("تغير الشفرة"),
            )
          ],
        ),
      ),
    );
  }
}
