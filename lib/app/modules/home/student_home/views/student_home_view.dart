import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_egabat/app/core/constants/loading/lottie_loading.dart';
import 'package:my_egabat/app/core/shared/errors/error_screen.dart';
import 'package:my_egabat/app/modules/home/student_home/views/widgets/subject_grid.dart';

import '../../../../core/shared/widgets/app_bottom_sheet.dart';
import '../controllers/student_home_controller.dart';
import 'widgets/custom_app_bar.dart';

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
        return const Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              CustomAppBar(),
              Expanded(
                child: SearchedSubjectGrid(),
              ),
              AppBottomSheet(),
            ],
          ),
        );
      },
    );
  }
}
