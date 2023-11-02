import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/loading/lottie_loading.dart';
import '../../../../../core/constants/styles/text_field_styles.dart';
import '../../../controllers/state_management/register_controller.dart';
import '../../../controllers/ui/register_edu_controller.dart';
import '../../../models/subject_model.dart';

class RegisterEducationalInfo extends GetView<RegisterController> {
  const RegisterEducationalInfo({this.isTeacher = false, super.key});
  final bool isTeacher;
  @override
  Widget build(BuildContext context) {
    controller.getSections();
    controller.getStages();
    RegisterEduController eduController = Get.find<RegisterEduController>();
    return Center(
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Obx(
              () => controller.isLoadingSection.value ||
                      controller.isLoadingStage.value ||
                      controller.isLoadingGrade.value ||
                      controller.isLoadingSubject.value
                  ? SmallLottieLoading()
                  : const SizedBox(),
            ),
            if (isTeacher)
              //show the subjects
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    eduController.showRegisterListBottomSheet(
                      controller.selectedSubjects.values.toList(),
                      (subject) {
                        (subject as AuthSubject).isChosen.value
                            ? {
                                controller.selectedSubjects.remove(subject.id),
                              }
                            : null;
                        subject.isChosen.value = false;
                        controller.updateSelectedSubjectsLength();
                      },
                      "رؤية المواد المختارة".tr,
                      context,
                      isShowSubjects: true,
                    );
                  },
                  child: Text("رؤية المواد المختارة".tr),
                ),
              ),
            // get section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                readOnly: true,
                onTap: () => eduController.showRegisterListBottomSheet(
                  controller.sections,
                  eduController.selectSection(isTeacher),
                  "اختر نوع مدرستك".tr,
                  context,
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? "اختر نوع مدرستك".tr : null,
                controller: controller.sectionController,
                decoration: authInputDecoration(labelText: "اختر نوع مدرستك".tr)
                    .copyWith(
                  suffixIcon: SizedBox(
                    child: eduController.selectTypeWidget(
                      controller.sections,
                      "اختر نوع مدرستك".tr,
                      context,
                      controller.isLoadingSection,
                      eduController.selectSection(isTeacher),
                    ),
                  ),
                  prefixIcon: const Icon(Icons.school),
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.stageController,
                onTap: () => eduController.showRegisterListBottomSheet(
                  controller.stages,
                  eduController.selectStage,
                  "اختر مرحلتك الدراسية".tr,
                  context,
                ),
                readOnly: true,
                validator: (value) =>
                    value?.isEmpty ?? true ? "اختر مرحلتك الدراسية".tr : null,
                decoration:
                    authInputDecoration(labelText: "اختر مرحلتك الدراسية".tr)
                        .copyWith(
                  prefixIcon: const Icon(FontAwesome.address_book),
                  suffixIcon: eduController.selectTypeWidget(
                    controller.stages,
                    "اختر مرحلتك الدراسية".tr,
                    context,
                    controller.isLoadingStage,
                    eduController.selectStage,
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.gradeController,
                onTap: () => eduController.showRegisterListBottomSheet(
                  controller.grades,
                  eduController.selectGrade(isTeacher),
                  "اختر صفك الدراسي".tr,
                  context,
                ),
                readOnly: true,
                validator: (value) =>
                    value?.isEmpty ?? true ? "اختر صفك الدراسي".tr : null,
                decoration:
                    authInputDecoration(labelText: "اختر صفك الدراسي".tr)
                        .copyWith(
                  prefixIcon: const Icon(Icons.book),
                  suffixIcon: eduController.selectTypeWidget(
                    controller.grades,
                    "اختر صفك الدراسي".tr,
                    context,
                    controller.isLoadingGrade,
                    eduController.selectGrade(isTeacher),
                  ),
                ),
              ),
            ),
            if (isTeacher)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: GlobalKey(),
                  readOnly: true,
                  onTap: () => eduController.showRegisterListBottomSheet(
                    controller.subjects,
                    eduController.selectSubject,
                    "اختر المواد التي تدرسها".tr,
                    context,
                    isSubjects: true,
                  ),
                  validator: (value) => controller.selectedSubjects.isEmpty
                      ? "اختر المواد التي تدرسها".tr
                      : null,
                  decoration: authInputDecoration(
                          labelText: "اختر المواد التي تدرسها".tr)
                      .copyWith(
                    prefixIcon: const Icon(FontAwesome.book),
                    suffixIcon: eduController.selectTypeWidget(
                      controller.subjects,
                      "اختر المواد التي تدرسها".tr,
                      context,
                      controller.isLoadingSubject,
                      eduController.selectSubject,
                      true,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
