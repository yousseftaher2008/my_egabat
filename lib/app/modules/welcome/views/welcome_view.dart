import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:introduction_screen/introduction_screen.dart";
import "package:my_egabat/app/core/data/models/introduction_page.dart";
import "../../../core/data/data_source/introduct_screen_dart.dart";
import "../../../core/shared/widgets/welcome_button.dart";
import "../../welcome/controllers/welcome_controller.dart";
import '../../../core/constants/styles/colors.dart';

import '../../../core/constants/styles/text_styles.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    PageViewModel pageViewModel(IntroductionPage introductionPage) =>
        PageViewModel(
          decoration: const PageDecoration(),
          titleWidget: Text(
            introductionPage.title,
            style: welcomeTitleTextStyle,
          ),
          bodyWidget: Text(
            introductionPage.body,
            style: welcomeBodyTextStyle,
          ),
          image: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(introductionPage.image),
          ),
        );
    return SafeArea(
      child: IntroductionScreen(
        rtl: true,
        globalBackgroundColor: primaryColor,
        pages: [
          pageViewModel(introductionScreenData[0]),
          pageViewModel(introductionScreenData[1]),
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
