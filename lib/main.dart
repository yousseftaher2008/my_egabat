import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_egabat/app/shared/styles/colors.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      textDirection: TextDirection.rtl,
      title: "Ai School",
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme:
            const ColorScheme.light(secondary: primaryColorTransparent),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
