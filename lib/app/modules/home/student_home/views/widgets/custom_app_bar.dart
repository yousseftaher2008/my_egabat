import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/core/constants/base_url.dart';
import 'package:my_egabat/app/core/shared/widgets/app_bars.dart';
import 'package:my_egabat/app/modules/home/student_home/controllers/student_home_controller.dart';

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${"اهلا".tr} ${controller.currentUser.userName!}",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: defaultUserImage,
                      image: (controller.currentUser.userImage?.isNotEmpty ??
                              false)
                          ? NetworkImage(
                              "$imageUrl${controller.currentUser.userImage}")
                          : defaultUserImage as ImageProvider,
                    ),
                  ),
                ),
              ],
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
              onPressed: () {},
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
