import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/loading/loading.dart';
import '../../../../../core/constants/styles/colors.dart';
import '../../controllers/student_search_controller.dart';
import 'subject_grid_item.dart';

class SearchedSubjectGrid extends GetView<StudentSearchController> {
  const SearchedSubjectGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.searchedValue.value.length < 3 &&
              !controller.isLastWasSubmit.value
          ? const Center()
          : controller.isGettingData.value
              ? Loading()
              : controller.searchedSubjectsLength.value == 0 &&
                      controller.searchedValue.value.isNotEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "لا يوجد مادة تحتوي على".tr,
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DefaultTextStyle(
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              child: Text(
                                "\n\"${controller.textEditingController.text}\"",
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(4),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2.5 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: controller.searchedSubjectsLength.value,
                      itemBuilder: (_, i) {
                        return SearchedSubjectGridItem(
                            controller.searchedSubjects[i]);
                      },
                    ),
    );
  }
}
