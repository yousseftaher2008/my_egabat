import 'package:flutter/material.dart';

import '../../../../../shared/styles/text_field_styles.dart';
import 'choose_country.dart';

class PhoneCountryInput extends StatelessWidget {
  const PhoneCountryInput(this.controller, {super.key});
  final dynamic controller;
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
                controller.login();
              },
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                controller.login();
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
