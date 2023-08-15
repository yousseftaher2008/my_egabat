import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/state_management/register_controller.dart';
import '../student/image_input.dart';
import '../../../../../shared/styles/text_field_styles.dart';

class RegisterPersonalInfo extends GetView<RegisterController> {
  const RegisterPersonalInfo({this.isTeacher = false, super.key});
  final bool isTeacher;
  @override
  Widget build(BuildContext context) {
    final RxBool isVisible = false.obs;
    void changeVisibility() => isVisible.value = !isVisible.value;
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
                decoration: authInputDecoration(labelText: "الاسم").copyWith(
                  prefixIcon: const Icon(Icons.person),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) => value?.isEmpty ?? true
                    ? "ادخل اسمك من فضلك"
                    : value!.length < 3
                        ? "يجب ان يكون اسمك من 3 حروف على الاقل"
                        : null,
              ),
            ),
            if (!isTeacher)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.nickNameController,
                  decoration: authInputDecoration(labelText: "الاسم المستعار")
                      .copyWith(prefixIcon: const Icon(Icons.person_outlined)),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value?.isEmpty ?? true
                      ? "ادخل اسمك المستعار من فضلك"
                      : value!.length < 3
                          ? "يجب ان يكون الاسم المستعار من 3 حروف على الاقل"
                          : null,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textInputAction:
                    isTeacher ? TextInputAction.next : TextInputAction.done,
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: authInputDecoration(labelText: "البريد الالكتروني")
                    .copyWith(
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                onFieldSubmitted: !isTeacher
                    ? (value) => controller.nextRegisterStep()
                    : null,
                validator: (value) => value?.isEmpty ?? true
                    ? "ادخل برديك الالكتروني"
                    : !value!.isEmail
                        ? "ادخل بريد الالكتروني صحيح"
                        : null,
              ),
            ),
            if (isTeacher)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: controller.passwordController,
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
                        : value!.length < 5
                            ? "يجب ان يكون رمز المرور 5 حروف على الاقل"
                            : null,
                    onFieldSubmitted: (_) => controller.nextRegisterStep(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
