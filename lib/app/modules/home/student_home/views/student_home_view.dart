import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/loading/lottie_loading.dart';
import '../../../../core/constants/styles/colors.dart';
import '../../../../core/shared/errors/error_screen.dart';
import '../../../../core/shared/widgets/app_bottom_sheet.dart';
import '../../../../data/models/app_pages_enum.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/student_home_controller.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/searched_subject_grid.dart';
import 'widgets/sub_lib/sub_lib.dart';

class StudentHomeView extends GetView<StudentHomeController> {
  const StudentHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final val = Get.arguments;
    return FutureBuilder(
      future: controller
          .getUser(val == null ? null : val["student"] ?? val["token"]),
      builder: (context, user) {
        if (user.connectionState == ConnectionState.waiting) {
          return Scaffold(body: LargeLottieLoading());
        }
        if (user.hasError) {
          return const ErrorScreen();
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              const CustomAppBar(),
              Expanded(
                child: Obx(
                  () => AppPages.currentPage.value != AppPagesEnum.home
                      ? const Center(
                          child: Text(
                            "Will Added Letter",
                            style: TextStyle(
                              fontSize: 30,
                              color: primaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        )
                      : controller.isSearching.value
                          ? const SearchedSubjectGrid()
                          : ListView(
                              children: const [
                                SubLib(true),
                                SubLib(false),
                              ],
                            ),
                ),
              ),
              const AppBottomSheet(),
            ],
          ),
        );
      },
    );
  }
}
