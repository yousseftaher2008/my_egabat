import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as launch;

import '../../constants/styles/colors.dart';
import '../../functions/errors_messages.dart';

class HelpButton extends StatelessWidget {
  const HelpButton(
      {required this.phoneNumber, this.startMessage = "", super.key});

  final String phoneNumber;
  final String startMessage;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: primaryColorLight,
          // backgroundColor: Colors.transparent,
          side: BorderSide(
            color: Colors.white,
            width: 2.w,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      icon: const Icon(FontAwesome.whatsapp),
      onPressed: () async {
        final Uri whatsappLink =
            Uri.parse("whatsapp://send?phone=$phoneNumber&text=$startMessage");
        try {
          await launch.canLaunchUrl(whatsappLink)
              ? await launch.launchUrl(whatsappLink)
              : whatsappLauncherError();
        } catch (e) {
          whatsappLauncherError();
        }
      },
      label: Text(
        "المساعدة".tr,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
