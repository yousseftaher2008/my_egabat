import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'help_button.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../../routes/app_pages.dart';

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
              height: 300,
              width: 300,
              child: Image.asset(
                "assets/error_image.png",
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: Text(
              "خطأ غير معروف!",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(Routes.MAIN);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColorTransparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: const BorderSide(color: Colors.white38, width: 2)),
            child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text("الرجوع للشاشة الرئيسية",
                    style: welcomeTitleTextStyle)),
          ),
          const SizedBox(height: 100),
          const HelpButton(
            phoneNumber: "+96599811025",
            startMessage: "",
          ),
        ],
      ),
    );
  }
}
