import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/register_controller.dart';
import '../student/image_input.dart';
import '../../../../../shared/styles/text_field_styles.dart';

class RegisterPersonalInformation extends GetView<RegisterController> {
  const RegisterPersonalInformation({this.withImageInput = true, super.key});
  final bool withImageInput;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              if (withImageInput) const ImageInput(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.nameController,
                  decoration: authInputDecoration(labelText: "الاسم"),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value?.isEmpty ?? true
                      ? "ادخل اسمك من فضلك"
                      : value!.length < 3
                          ? "يجب ان يكون اسمك من 3 حروف على الاقل"
                          : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.nickNameController,
                  decoration: authInputDecoration(labelText: "الاسم المستعار"),
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
                  controller: controller.studentEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      authInputDecoration(labelText: "البريد الالكتروني"),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) => controller.nextRegisterStep(),
                  validator: (value) => value?.isEmpty ?? true
                      ? "ادخل برديك الالكتروني"
                      : !value!.isEmail
                          ? "ادخل بريد الالكتروني صحيح"
                          : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
