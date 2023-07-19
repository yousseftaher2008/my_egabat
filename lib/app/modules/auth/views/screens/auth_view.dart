import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:my_egabat/app/shared/styles/button_styles.dart';
import '../../../../shared/styles/colors.dart';

import '../../../../shared/styles/text_styles.dart';
import '../../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();
    void fun() {
      phoneKey.currentState!.validate();
    }

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: primaryColorTransparent,
          body: Stack(
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: ColoredBox(
                  color: primaryColor,
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Image.asset("assets/login_image.png"),
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 250,
                  child: TextFormField(
                    key: phoneKey,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: textFormFieldStyle,
                    decoration: InputDecoration(
                      hintText: "رقم الهاتف",
                      hintStyle: textFormFieldStyle,
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
                    validator: (va) => "error",
                  ),
                ),
              ),
              Positioned(
                bottom: 200,
                right: Get.size.width / 2 - 50,
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: primaryButtonStyle,
                    onPressed: () {},
                    child: const Text("Login"),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
