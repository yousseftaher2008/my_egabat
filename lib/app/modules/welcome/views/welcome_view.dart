import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:introduction_screen/introduction_screen.dart";

import '../../../core/constants/styles/colors.dart';
import '../../../core/constants/styles/text_styles.dart';
import "../../../core/shared/widgets/welcome_button.dart";
import '../../../data/data_source/introduction_screen_dart.dart';
import '../../../data/models/introduction_page.dart';
import "../../welcome/controllers/welcome_controller.dart";

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
            margin: EdgeInsets.all(10.sp),
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
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
          activeSize: Size(30.w, 7.h),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          size: Size.square(7.sp),
        ),
      ),
    );
  }
}
