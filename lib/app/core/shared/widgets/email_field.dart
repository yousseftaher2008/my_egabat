import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/styles/text_field_styles.dart';

class AppEmailField extends StatelessWidget {
  const AppEmailField(
    this.textEditingController, {
    this.onFieldSubmitted,
    this.hintText = "رمز المرور",
    this.moreValidating,
    this.textInputAction,
    super.key,
  });
  final TextEditingController textEditingController;
  final TextInputAction? textInputAction;
  final Function(String value)? onFieldSubmitted;
  final String hintText;
  final String? Function()? moreValidating;
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: TextFormField(
        textInputAction: textInputAction,
        controller: textEditingController,
        keyboardType: TextInputType.emailAddress,
        decoration:
            authInputDecoration(labelText: "ادخل برديك الالكتروني".tr).copyWith(
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) => value?.isEmpty ?? true
            ? "ادخل برديك الالكتروني".tr
            : !value!.isEmail
                ? "ادخل بريد الالكتروني صحيح".tr
                : null,
      ),
    );
  }
}
