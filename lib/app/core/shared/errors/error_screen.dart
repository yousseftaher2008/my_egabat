import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../constants/styles/colors.dart';
import '../../constants/styles/text_styles.dart';
import 'help_button.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 300.h,
              width: 300.w,
              child: Image.asset(
                "assets/error_image.png",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
            child: Text(
              "خطأ غير معروف!".tr,
              style: xLargeBoldWhite,
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(Routes.MAIN);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColorLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                side: const BorderSide(color: Colors.white38, width: 2)),
            child: Padding(
                padding: EdgeInsets.all(10.r),
                child: Text("الرجوع للشاشة الرئيسية".tr,
                    style: welcomeTitleTextStyle)),
          ),
          SizedBox(height: 100.h),
          const HelpButton(
            phoneNumber: "+96599811025",
          ),
        ],
      ),
    );
  }
}
