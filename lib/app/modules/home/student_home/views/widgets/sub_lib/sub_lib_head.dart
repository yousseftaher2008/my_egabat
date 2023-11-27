import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/constants/styles/colors.dart';
import '../../screens/sub_lib_screen.dart';

class SubLibHead extends StatelessWidget {
  const SubLibHead(this.isSub, {super.key});
  final bool isSub;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10.h,
        right: 20.w,
        left: 20.w,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isSub ? "المواد".tr : "المكتبات".tr,
            style: TextStyle(
              fontSize: 25.sp,
              color: infoColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.to(SubLibScreen(isSub));
            },
            child: Text(
              "رؤية الكل".tr,
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
