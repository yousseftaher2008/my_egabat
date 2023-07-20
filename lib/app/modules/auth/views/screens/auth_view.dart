import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../../../../shared/styles/button_styles.dart';
import '../../../../shared/styles/colors.dart';

import '../../../../shared/styles/text_styles.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/choose_country.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double pageHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColorTransparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: ColoredBox(
                  color: primaryColor,
                  child: SizedBox(
                    height: pageHeight / 3,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Image.asset("assets/login_image.png"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: pageHeight / 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        key: controller.phoneKey,
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        style: textFormFieldStyle,
                        decoration: InputDecoration(
                          labelText: "رقم الهاتف",
                          labelStyle: textFormFieldStyle,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                          ),
                        ),
                        validator: (_) => controller.errorText,
                      ),
                    ),
                    const ChooseCountry()
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  style: primaryButtonStyle,
                  onPressed: controller.login,
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
