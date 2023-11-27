import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/base_url.dart';
import '../../../../../core/constants/loading/loading.dart';
import '../../../../../core/constants/styles/colors.dart';
import '../../../../../core/constants/styles/text_styles.dart';
import '../../../../../data/models/country_model.dart';
import '../../../controllers/state_management/auth_controller.dart';

class ChooseCountry extends GetView<AuthController> {
  const ChooseCountry({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getCountries();

    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          controller.isGettingCountries.value
              ? Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Loading(),
                )
              : TextButton(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Obx(
                      () => Text(
                        controller.selectedCountryCode.value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.r),
                          topLeft: Radius.circular(30.r),
                        ),
                      ),
                      builder: (_) => Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15.sp),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.r),
                                topLeft: Radius.circular(30.r),
                              ),
                              color: primaryColor,
                            ),
                            child: Text(
                              "اختر دولتك".tr,
                              textAlign: TextAlign.center,
                              style: welcomeTitleTextStyle,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: (controller.countries)
                                  .map(
                                    (Country country) => Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.black,
                                          side: BorderSide(
                                            width: 0.5.w,
                                            color: Colors.grey,
                                          ),
                                          shape: const RoundedRectangleBorder(),
                                          backgroundColor:
                                              Colors.white.withOpacity(0.6),
                                          foregroundColor: primaryColor,
                                        ),
                                        onPressed: () {
                                          controller.selectCountryByCode(
                                              country.code);
                                          Get.back();
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Spacer(),
                                            CircleAvatar(
                                              radius: 50.r,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: FadeInImage(
                                                placeholder: const AssetImage(
                                                  "assets/unknown_flag.png",
                                                ),
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "$imageUrl${country.flag}",
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text(
                                              country.name,
                                              style: welcomeTitleTextStyle
                                                  .copyWith(
                                                color: primaryButtonColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Text(
                                              country.code,
                                              style:
                                                  welcomeBodyTextStyle.copyWith(
                                                color: primaryButtonColor,
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
