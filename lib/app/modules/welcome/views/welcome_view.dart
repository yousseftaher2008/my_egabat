import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:introduction_screen/introduction_screen.dart";
import "../../welcome/controllers/welcome_controller.dart";
import "../../../shared/styles/colors.dart";

import "../../../shared/styles/button_styles.dart";
import "../../../shared/styles/text_styles.dart";

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        // rtl: true,
        rtl: true,
        globalBackgroundColor: primaryColor,
        pages: [
          PageViewModel(
            titleWidget: Text(
              "تعلم من افضل المدرسين".tr,
              style: welcomeTitleTextStyle,
            ),
            bodyWidget: Text(
              "استمع لافضل المدرسين في كل المواد وانت في بيتك".tr,
              style: welcomeBodyTextStyle,
            ),
            image: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

                // color: const Color(0xF0F2F2F2),
              ),
              child: Image.asset("assets/first_welcome_image.png"),
            ),
          ),
          PageViewModel(
            decoration: const PageDecoration(),
            titleWidget: Text(
              "اسال زملائك و مدرسينك".tr,
              style: welcomeTitleTextStyle,
            ),
            bodyWidget: Text(
              "تواصل مع زملائك و مدرسينك واسالهم عن كل ما يعارضك في طريقك".tr,
              style: welcomeBodyTextStyle,
            ),
            image: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset("assets/second_welcome_image.png"),
            ),
          ),
        ],
        showBackButton: true,
        showNextButton: true,
        back: welcomeButton("السابق".tr),
        next: welcomeButton("التالي".tr),
        done: welcomeButton("تم".tr),
        onDone: controller.done,
        dotsDecorator: DotsDecorator(
          color: Colors.white,
          activeColor: Colors.white,
          activeSize: const Size(30, 7),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          size: const Size.square(7),
        ),
      ),
    );
  }
}
