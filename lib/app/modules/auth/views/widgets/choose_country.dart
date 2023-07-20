import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/auth_controller.dart';
import 'package:my_egabat/app/modules/auth/models/country_model.dart';

import '../../../../shared/base_url.dart';
import '../../../../shared/styles/text_styles.dart';

class ChooseCountry extends GetView<AuthController> {
  const ChooseCountry({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getCountries();

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 3, color: Colors.white)),
      width: 250,
      alignment: Alignment.centerLeft,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                controller.selectedCountryCode.value,
                style: textFormFieldStyle,
                textDirection: TextDirection.ltr,
              ),
            ),
            controller.isGettingCountries.value
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                : PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onSelected: (value) {
                      for (int i = 0; i < controller.countries.length; i++) {
                        if (controller.countries[i].code != value ||
                            controller.selectedCountryCode.value == value) {
                          continue;
                        }
                        controller.selectedCountry = controller.countries[i];
                        controller.selectedCountryCode.value = value;
                      }
                    },
                    initialValue: "",
                    itemBuilder: (_) => (controller.countries)
                        .map(
                          (Country country) => PopupMenuItem(
                            value: country.code,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(country.name),
                                Text(
                                  country.code,
                                  textDirection: TextDirection.ltr,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                    "$imageUrl${country.flag}",
                                  ),
                                  radius: 15,
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
          ],
        ),
      ),
    );
  }
}
