import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../models/country_model.dart';

import '../../../../shared/base_url.dart';
import '../../../../shared/styles/colors.dart';

class ChooseCountry extends GetView<AuthController> {
  const ChooseCountry({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getCountries();

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.5,
            color: controller.selectedCountryCode.value != "اختر دولتك"
                ? primaryColorTransparent
                : Colors.black,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            controller.isGettingCountries.value
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: primaryColorTransparent,
                    ),
                  )
                : PopupMenuButton(
                    icon: Icon(
                      Icons.arrow_drop_down_sharp,
                      color:
                          controller.selectedCountryCode.value != "اختر دولتك"
                              ? primaryColorTransparent
                              : Colors.black,
                    ),
                    onSelected: controller.selectCountryByCode,
                    initialValue: "",
                    itemBuilder: (_) => (controller.countries)
                        .map(
                          (Country country) => PopupMenuItem(
                            value: country.code,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(country.name),
                                Text(
                                  country.code,
                                  textDirection: TextDirection.ltr,
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.transparent,
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
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                controller.selectedCountryCode.value,
                textDirection: TextDirection.ltr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
