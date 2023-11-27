import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/base_url.dart';
import '../../../../../core/constants/screen_dimensions.dart';
import '../../../../../core/constants/styles/colors.dart';
import '../../../../../core/localization/local.dart';
import '../../../../../core/shared/widgets/app_bars.dart';
import '../../../../../core/shared/widgets/default_user_image.dart';
import '../../../../../data/models/app_local.dart';
import '../../controllers/student_home_controller.dart';
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
        padding: EdgeInsets.only(
          top: 40.0.h,
          bottom: 8.0.h,
          left: 8.0.w,
          right: 8.0.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: secondaryColor.withOpacity(0.6),
              ),
              height: 50.h,
              width: 50.w,
              child: (controller.currentUser.userImage?.isNotEmpty ?? false)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(25.r),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: defaultUserImage,
                        image: NetworkImage(
                            "$imageUrl${controller.currentUser.userImage}"),
                      ),
                    )
                  : userImageByName(controller.currentUser.userName!),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: AnimSearchBar(
                  width: pageWidth() - 110.w,
                  rtl: appLocal == AppLocal.en,
                  searchIconColor: Colors.white,
                  color: Colors.transparent,
                  textController: studentSearchController.textEditingController,
                  onChanged: (val) {
                    studentSearchController.isLastWasSubmit.value = false;
                    studentSearchController.onValueChanged(val);
                  },
                  onSubmitted: (val) {
                    studentSearchController.isLastWasSubmit.value = true;
                    studentSearchController.onValueChanged(val, must: true);
                  }),
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
