import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/auth_controller.dart';

import '../../../../shared/styles/colors.dart';
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
            child: Obx(
              () => TextFormField(
                key: controller.phoneKey,
                onTap: () => controller.isFocus.value = true,
                onFieldSubmitted: (_) {
                  controller.isFocus.value = false;
                  FocusScope.of(context).unfocus();
                  controller.login();
                },
                onEditingComplete: () {
                  controller.isFocus.value = false;
                  FocusScope.of(context).unfocus();
                  controller.login();
                },
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "رقم الهاتف",
                  labelStyle: TextStyle(
                    color: controller.isError.value
                        ? Colors.red
                        : controller.isFocus.value
                            ? primaryColorTransparent
                            : Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: primaryColorTransparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: primaryButtonColor,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 1.5, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 1.5, color: Colors.red),
                  ),
                ),
                validator: (_) => controller.errorText,
              ),
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
