import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/constants/styles/colors.dart';

class SubLibHead extends StatelessWidget {
  const SubLibHead(this.isSub, {super.key});
  final bool isSub;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        right: 20,
        left: 20,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isSub ? "المواد".tr : "المكتبات".tr,
            style: const TextStyle(
              fontSize: 25,
              color: infoColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
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