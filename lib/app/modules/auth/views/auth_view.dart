import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/loading/lottie_loading.dart';
import '../../../core/constants/screen_dimensions.dart' as size;
import '../../../core/constants/styles/colors.dart';
import '../controllers/state_management/auth_controller.dart';
import '../controllers/state_management/reset_password_controller.dart';
import 'widgets/student/student_auth.dart';
import 'widgets/teacher/reset_password.dart';
import 'widgets/teacher/teacher_auth.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double pageHeight =
        size.pageHeight() - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => controller.isInit.value
              ? LargeLottieLoading()
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        height: pageHeight,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipPath(
                              clipper: OvalBottomBorderClipper(),
                              child: Container(
                                color: primaryColor,
                                height: pageHeight / 3,
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.all(8.sp),
                                  child: Obx(
                                    () => Image.asset(
                                      controller.isTeacher.value
                                          ? controller.isChangingPass.value
                                              ? "assets/change_pass.png"
                                              : "assets/teacher_image.png"
                                          : "assets/student_image.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => controller.isTeacher.value
                                  ? controller.isChangingPass.value
                                      ? const ResetPassword()
                                      : const TeacherAuth()
                                  : const StudentAuth(),
                            ),
                            Obx(
                              () => TextButton(
                                onPressed: () {
                                  controller.changeUserType();
                                },
                                child: Text(
                                  controller.isTeacher.value
                                      ? "انا طالب ولست مدرس؟".tr
                                      : "انا مدرس ولست طالبا؟".tr,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.registerController.isRegister.value ||
                              controller.isChangingPass.value
                          ? Padding(
                              padding: EdgeInsets.all(16.0.sp),
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 30,
                                      spreadRadius: 10,
                                      color: primaryButtonColor,
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    if (controller.isChangingPass.value) {
                                      controller.isChangingPass.value = false;
                                      Get.delete<ResetPasswordController>();
                                    }

                                    controller.registerController
                                        .backFromRegister();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 35.sp,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
