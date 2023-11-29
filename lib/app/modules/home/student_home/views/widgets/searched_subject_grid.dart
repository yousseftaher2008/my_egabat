import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/loading/loading.dart';
import '../../../../../core/constants/styles/text_styles.dart';
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
                        padding: EdgeInsets.all(8.0.sp),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "لا يوجد مادة تحتوي على".tr,
                              style: h3BoldPrimary,
                            ),
                            DefaultTextStyle(
                              style: h3BoldPrimary,
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
                      padding: EdgeInsets.all(4.sp),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2.5 / 2,
                        crossAxisSpacing: 10.h,
                        mainAxisSpacing: 10.w,
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
