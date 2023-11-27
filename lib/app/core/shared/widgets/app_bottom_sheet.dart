import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/models/app_pages_enum.dart';
import '../../../routes/app_pages.dart';
import '../../constants/styles/colors.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle(AppPagesEnum page) {
      return TextStyle(
        color:
            AppPages.currentPage.value == page ? primaryColor : secondaryColor,
      );
    }

    Widget pageWidget(
      String pageName,
      AppPagesEnum pageEnumName, {
      String? iconImageAsset,
      String? iconImageAssetOutline,
      IconData? pageIcon,
      IconData? pageIconOutline,
    }) =>
        Obx(
          () {
            final bool isInThisPage =
                AppPages.currentPage.value == pageEnumName;
            return SizedBox(
              height: 75,
              child: GestureDetector(
                onTap: () {
                  if (!isInThisPage) {
                    AppPages.currentPage.value = pageEnumName;
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0.h),
                      child: iconImageAsset != null &&
                              iconImageAssetOutline != null
                          ? Image.asset(
                              isInThisPage
                                  ? iconImageAsset
                                  : iconImageAssetOutline,
                              width: 25.w,
                              height: 25.h,
                            )
                          : Icon(
                              isInThisPage
                                  ? pageIcon
                                  : pageIconOutline ?? pageIcon,
                              color:
                                  isInThisPage ? primaryColor : secondaryColor,
                            ),
                    ),
                    FittedBox(
                      child: Text(
                        pageName,
                        style: defaultStyle(pageEnumName),
                      ),
                    ),
                    const SizedBox()
                  ],
                ),
              ),
            );
          },
        );

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x3f000000),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          pageWidget(
            "الرئيسية".tr,
            AppPagesEnum.home,
            pageIcon: Icons.home,
            pageIconOutline: Icons.home_outlined,
          ),
          pageWidget(
            "تواصل".tr,
            AppPagesEnum.communicate,
            pageIcon: Icons.person,
            pageIconOutline: Icons.person_outline_sharp,
          ),
          pageWidget(
            "الاختبارات".tr,
            AppPagesEnum.quiz,
            pageIcon: Icons.quiz,
            pageIconOutline: Icons.quiz_outlined,
          ),
          pageWidget(
            "المسابقات".tr,
            AppPagesEnum.comps,
            iconImageAsset: "assets/competition.png",
            iconImageAssetOutline: "assets/competition_outline.png",
          ),
          pageWidget(
            "الفيديوهات".tr,
            AppPagesEnum.videos,
            pageIcon: Icons.video_collection,
            pageIconOutline: Icons.video_collection_outlined,
          ),
          pageWidget(
            "الأسئلة".tr,
            AppPagesEnum.questions,
            pageIcon: Icons.question_answer,
            pageIconOutline: Icons.question_answer_outlined,
          ),
        ],
      ),
    );
  }
}
