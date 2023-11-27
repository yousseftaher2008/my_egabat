import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/styles/button_styles.dart';
import '../../../../../core/constants/styles/text_field_styles.dart';
import '../../../../../core/shared/widgets/password_field.dart';
import '../../../controllers/state_management/reset_password_controller.dart';

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
              padding: EdgeInsets.all(8.0.sp),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: controller.resetCodeController,
                decoration: authInputDecoration(
                        labelText: "ادخل الكود الذي ارسل اليك".tr)
                    .copyWith(
                  prefixIcon: const Icon(Icons.code),
                ),
                validator: (value) {
                  return (value?.isEmpty) ?? true
                      ? "ادخل الكود الذي ارسل اليك".tr
                      : value != controller.expectedCode
                          ? "يرجى ادخال كود صحيح".tr
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
              hintText: "رمز المرور مرة اخرى".tr,
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
              child: Text("تغير الشفرة".tr),
            )
          ],
        ),
      ),
    );
  }
}
