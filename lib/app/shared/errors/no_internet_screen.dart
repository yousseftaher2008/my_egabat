// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget stepWidget(String stepText) => Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: Color.fromARGB(255, 107, 105, 105),
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              stepText,
              style: TextStyle(
                color: Color.fromARGB(255, 107, 105, 105),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              color: Colors.grey,
              size: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "لا يوجد اتصال بالانترنت".tr,
                style: TextStyle(
                  color: Color.fromARGB(255, 107, 105, 105),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            stepWidget("(router or modem) تحقق من جهاز".tr),
            SizedBox(height: 15),
            stepWidget("او أعد الاتصال بشبكة Wifi او بيانات الهاتف او".tr),
          ],
        ),
        // ),
      ),
    );
  }
}
