import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/core/localization/local.dart';
import 'package:my_egabat/app/modules/auth/controllers/state_management/auth_controller.dart';
import 'package:my_egabat/app/modules/auth/models/app_local.dart';

import '../../../../../shared/styles/text_field_styles.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                suffixIcon: const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ChooseCountry(),
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
