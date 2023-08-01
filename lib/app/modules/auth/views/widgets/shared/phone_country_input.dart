import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/auth_controller.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              key: controller.phoneKey,
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
              decoration: authInputDecoration(labelText: "رقم الهاتف").copyWith(
                  suffixIcon: const SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ChooseCountry(),
                ),
              )),
              validator: (_) => controller.errorText,
            ),
          ),
        ),
      ],
    );
  }
}
