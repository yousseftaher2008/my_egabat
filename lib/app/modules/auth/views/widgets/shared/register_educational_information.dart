import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/state_management/register_controller.dart';
import 'package:my_egabat/app/modules/auth/controllers/ui/register_edu_controller.dart';
import 'package:my_egabat/app/shared/loading/loading.dart';
import '../../../../../shared/styles/text_field_styles.dart';
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
                  ? Loading()
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
                        (subject as Subject).isChosen.value
                            ? {
                                controller.selectedSubjects.remove(subject.id),
                              }
                            : null;
                        subject.isChosen.value = false;
                        controller.updateSelectedSubjectsLength();
                      },
                      "رؤية المواد المختارة",
                      context,
                      isShowSubjects: true,
                    );
                  },
                  child: const Text("رؤية المواد المختارة"),
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
                  "اختر نوع مدرستك",
                  context,
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? "اختر نوع مدرستك من فضلك" : null,
                controller: controller.sectionController,
                decoration:
                    authInputDecoration(labelText: "اختر نوع المدرسة").copyWith(
                  suffixIcon: SizedBox(
                    child: eduController.selectTypeWidget(
                      controller.sections,
                      "اختر نوع مدرستك",
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
                  "اختر مرحلتك الدراسية",
                  context,
                ),
                readOnly: true,
                validator: (value) => value?.isEmpty ?? true
                    ? "اختر مرحلتك الدراسيه من فضلك"
                    : null,
                decoration:
                    authInputDecoration(labelText: "اختر المرحلة الدراسية")
                        .copyWith(
                  prefixIcon: const Icon(FontAwesome.address_book),
                  suffixIcon: eduController.selectTypeWidget(
                    controller.stages,
                    "اختر مرحلتك الدراسية",
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
                  "اختر صفك الدراسي",
                  context,
                ),
                readOnly: true,
                validator: (value) =>
                    value?.isEmpty ?? true ? "اختر صفك الدراسي من فضلك" : null,
                decoration: authInputDecoration(labelText: "اختر الصف الدراسي")
                    .copyWith(
                  prefixIcon: const Icon(Icons.book),
                  suffixIcon: eduController.selectTypeWidget(
                    controller.grades,
                    "اختر صفك الدراسي",
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
                    "اختر المادة",
                    context,
                    isSubjects: true,
                  ),
                  validator: (value) => controller.selectedSubjects.isEmpty
                      ? "اختر المواد من فضلك"
                      : null,
                  decoration:
                      authInputDecoration(labelText: "اختر المواد التي تدرسها")
                          .copyWith(
                    prefixIcon: const Icon(FontAwesome.book),
                    suffixIcon: eduController.selectTypeWidget(
                      controller.subjects,
                      "اختر المواد",
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
