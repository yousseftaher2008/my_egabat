import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/core/constants/base_url.dart';
import 'package:my_egabat/app/core/constants/styles/colors.dart';
import 'package:my_egabat/app/core/shared/widgets/app_bars.dart';
import 'package:my_egabat/app/modules/home/student_home/controllers/student_home_controller.dart';
import 'package:my_egabat/app/modules/home/student_home/views/screens/qr_code_screen.dart';

import '../../../../../core/shared/widgets/default_user_image.dart';

class CustomAppBar extends GetView<StudentHomeController> {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return firstAppBar(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 40.0,
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: secondaryColor,
              ),
              height: 50,
              width: 50,
              child: (controller.currentUser.userImage?.isNotEmpty ?? false)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: defaultUserImage,
                        image: NetworkImage(
                            "$imageUrl${controller.currentUser.userImage}"),
                      ),
                    )
                  : userImageByName(controller.currentUser.userName!),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => const QrCodeScreen());
              },
              icon: const Icon(
                Icons.qr_code_2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
