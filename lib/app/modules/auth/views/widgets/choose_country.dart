import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/auth_controller.dart';
import 'package:my_egabat/app/modules/auth/models/country_model.dart';

import '../../../../shared/base_url.dart';
import '../../../../shared/styles/colors.dart';

class ChooseCountry extends GetView<AuthController> {
  const ChooseCountry({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getCountries();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
        ),
      ),
      child: Obx(
        () => Row(
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
                    icon: const Icon(
                      Icons.arrow_drop_down_sharp,
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
                            onTap: () {
                              // controller.filterOption.value = FilterOption.favorites;
                            },
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
