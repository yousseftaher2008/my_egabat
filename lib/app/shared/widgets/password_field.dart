import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/text_field_styles.dart';

class AppPasswordField extends StatelessWidget {
  const AppPasswordField(
    this.textEditingController, {
    this.onFieldSubmitted,
    this.hintText,
    this.moreValidating,
    this.textInputAction,
    super.key,
  });
  final TextEditingController textEditingController;
  final TextInputAction? textInputAction;
  final Function(String value)? onFieldSubmitted;
  final String? hintText;
  final String? Function()? moreValidating;
  @override
  @override
  Widget build(BuildContext context) {
    final RxBool isVisible = false.obs;
    void changeVisibility() => isVisible.value = !isVisible.value;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => TextFormField(
          controller: textEditingController,
          textInputAction: textInputAction,
          obscureText: !isVisible.value,
          decoration:
              authInputDecoration(hintText: hintText ?? "ادخل رمز المرور".tr)
                  .copyWith(
            prefixIcon: IconButton(
              onPressed: changeVisibility,
              icon: Icon(
                isVisible.value ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          validator: (value) => value?.isEmpty ?? true
              ? "ادخل رمز المرور".tr
              : value!.length < 5
                  ? "يجب ان يكون رمز المرور 5 حروف على الاقل".tr
                  : moreValidating != null
                      ? moreValidating!()
                      : null,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}
