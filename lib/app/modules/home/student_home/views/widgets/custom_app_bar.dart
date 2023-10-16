import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/core/constants/base_url.dart';
import 'package:my_egabat/app/core/constants/styles/colors.dart';
import 'package:my_egabat/app/core/localization/local.dart';
import 'package:my_egabat/app/core/shared/widgets/app_bars.dart';
import 'package:my_egabat/app/data/models/app_local.dart';
import 'package:my_egabat/app/modules/home/student_home/controllers/student_home_controller.dart';

import '../../../../../core/shared/widgets/default_user_image.dart';
import '../../controllers/student_search_controller.dart';
import 'anim_search_bar.dart';

class CustomAppBar extends GetView<StudentHomeController> {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentSearchController studentSearchController =
        Get.find<StudentSearchController>();
    return firstAppBar(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 40.0,
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: secondaryColor.withOpacity(0.6),
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
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: AnimSearchBar(
                width: Get.size.width - 110,
                rtl: appLocal == AppLocal.en,
                searchIconColor: Colors.white,
                color: Colors.transparent,
                textController: studentSearchController.textEditingController,
                onChanged: studentSearchController.onValueChanged,
                onSubmitted: studentSearchController.onValueChanged,
              ),
            ),
            IconButton(
              onPressed: () {
                FlutterBarcodeScanner.scanBarcode(
                        "$primaryColor", "الغاء".tr, true, ScanMode.QR)
                    .then(controller.qrLogin);
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
