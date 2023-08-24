import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/state_management/auth_controller.dart';

import '../../../../../shared/loading/loading.dart';
import '../../../../../shared/styles/button_styles.dart';
import '../../../../../shared/styles/text_field_styles.dart';

class TeacherLogin extends GetView<AuthController> {
  const TeacherLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final RxBool isVisible = false.obs;
    void changeVisibility() => isVisible.value = !isVisible.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Form(
          key: controller.teacherFromKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.teacherEmailController,
                  decoration: authInputDecoration(hintText: "البريد الالكتروني")
                      .copyWith(prefixIcon: const Icon(Icons.email_outlined)),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value?.isEmpty ?? true
                      ? "ادخل بريدك الالكتروني من فضلك"
                      : !value!.isEmail
                          ? "ادخل بريد الكتروني صحيح من فضلك"
                          : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => TextFormField(
                    controller: controller.teacherPassController,
                    obscureText: !isVisible.value,
                    decoration:
                        authInputDecoration(hintText: "رمز المرور").copyWith(
                      prefixIcon: IconButton(
                        onPressed: changeVisibility,
                        icon: Icon(
                          isVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) => value?.isEmpty ?? true
                        ? "ادخل رمز المرور من فضلك"
                        : value!.length < 8
                            ? "يجب ان يكون رمز المرور 8 حروف على الاقل"
                            : null,
                    onFieldSubmitted: (_) => controller.teacherLogin(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Obx(
              () => controller.isLogging.value
                  ? Loading()
                  : ElevatedButton(
                      style: primaryButtonStyle,
                      onPressed: controller.teacherLogin,
                      child: const Text("تسجيل الدخول"),
                    ),
            ),
            TextButton(
              onPressed: controller.registerController.nextRegisterStep,
              child: const Text(
                "تسجيل كمعلم زائر",
              ),
            ),
          ],
        )
      ],
    );
  }
}
