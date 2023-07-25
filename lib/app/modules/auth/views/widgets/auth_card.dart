import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

import '../../../../shared/styles/text_field_styles.dart';
import 'choose_country.dart';

class AuthCard extends GetView<AuthController> {
  const AuthCard({super.key});

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
              decoration: authInputDecoration(labelText: "رقم الهاتف"),
              validator: (_) => controller.errorText,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ChooseCountry(),
        )
      ],
    );
  }
}
