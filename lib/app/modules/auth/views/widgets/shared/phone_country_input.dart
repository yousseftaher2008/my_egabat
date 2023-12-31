import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/styles/text_field_styles.dart';
import '../../../../../core/localization/local.dart';
import '../../../../../data/models/app_local.dart';
import '../../../controllers/state_management/auth_controller.dart';
import 'choose_country.dart';

class PhoneCountryInput extends GetView<AuthController> {
  const PhoneCountryInput({this.onSaved, super.key});
  final Future<void> Function()? onSaved;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: TextFormField(
              key: controller.phoneKey,
              textAlign: TextAlign.left,
              onFieldSubmitted: (_) {
                FocusScope.of(context).unfocus();
                onSaved != null ? onSaved!() : null;
              },
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                onSaved != null ? onSaved!() : null;
              },
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              decoration:
                  authInputDecoration(labelText: "رقم الهاتف".tr).copyWith(
                suffixIcon: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: const ChooseCountry(),
                  ),
                ),
                prefixIcon: Icon(
                  appLocal == AppLocal.ar ? Icons.phone_enabled : Icons.phone,
                ),
              ),
              validator: (_) => controller.errorText,
            ),
          ),
        ),
      ],
    );
  }
}
