import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/shared/widgets/email_field.dart';
import 'package:my_egabat/app/shared/widgets/password_field.dart';
import '../../../controllers/state_management/register_controller.dart';
import '../student/image_input.dart';
import '../../../../../shared/styles/text_field_styles.dart';

class RegisterPersonalInfo extends GetView<RegisterController> {
  const RegisterPersonalInfo({this.isTeacher = false, super.key});
  final bool isTeacher;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            if (!isTeacher) const ImageInput(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.nameController,
                decoration:
                    authInputDecoration(labelText: "ادخل اسمك".tr).copyWith(
                  prefixIcon: const Icon(Icons.person),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) => value?.isEmpty ?? true
                    ? "ادخل اسمك".tr
                    : value!.length < 3
                        ? "يجب ان يكون اسمك من 3 حروف على الاقل".tr
                        : null,
              ),
            ),
            if (!isTeacher)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.nickNameController,
                  decoration: authInputDecoration(
                          labelText: "ادخل اسمك المستعار".tr)
                      .copyWith(prefixIcon: const Icon(Icons.person_outlined)),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value?.isEmpty ?? true
                      ? "ادخل اسمك المستعار".tr
                      : value!.length < 3
                          ? "يجب ان يكون الاسم المستعار من 3 حروف على الاقل".tr
                          : null,
                ),
              ),
            AppEmailField(
              controller.emailController,
              textInputAction:
                  isTeacher ? TextInputAction.next : TextInputAction.done,
              onFieldSubmitted:
                  !isTeacher ? (value) => controller.nextRegisterStep() : null,
            ),
            if (isTeacher)
              AppPasswordField(
                controller.passwordController,
                onFieldSubmitted: (_) => controller.nextRegisterStep(),
              )
          ],
        ),
      ),
    );
  }
}
