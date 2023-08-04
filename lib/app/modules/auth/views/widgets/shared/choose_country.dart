// TODO: edit the style (right, left)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/auth_controller.dart';
import 'package:my_egabat/app/shared/base_url.dart';
import 'package:my_egabat/app/shared/styles/text_styles.dart';
import '../../../models/country_model.dart';

import '../../../../../shared/styles/colors.dart';

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
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: primaryColorTransparent,
                  ),
                )
              : TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      builder: (_) => Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              ),
                              color: primaryColor,
                            ),
                            child: const Text(
                              "اختر دولتك",
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
                                          side: const BorderSide(
                                            width: 0.5,
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
                                              radius: 50,
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
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              country.name,
                                              style: welcomeTitleTextStyle
                                                  .copyWith(
                                                color: primaryButtonColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
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
