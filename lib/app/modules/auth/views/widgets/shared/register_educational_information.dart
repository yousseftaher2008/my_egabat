// TODO: see the chosen subjects
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/ui/register_edu_controller.dart';
import '../../../../../shared/styles/text_field_styles.dart';
import '../../../models/subject_model.dart';

class RegisterEducationalInfo extends GetView<RegisterEduController> {
  const RegisterEducationalInfo({this.isTeacher = false, super.key});
  final bool isTeacher;
  @override
  Widget build(BuildContext context) {
    controller.getSections();
    controller.getStages();

    return Center(
      child: Form(
        key: controller.formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Obx(
              () => controller.isLoadingGrades.value ||
                      controller.isLoadingSections.value ||
                      controller.isLoadingStages.value ||
                      controller.isLoadingSubjects.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox(),
            ),
            //show the subjects
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.showRegisterListBottomSheet(
                    controller.selectedSubjects.values.toList(),
                    (subject) {
                      (subject as Subject).isChosen.value
                          ? {
                              controller.selectedSubjects.remove(subject.id),
                              controller.selectedSubjects.value =
                                  controller.selectedSubjects
                            }
                          : null;
                      subject.isChosen.value = false;
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
                validator: (value) =>
                    value?.isEmpty ?? true ? "اختر نوع مدرستك من فضلك" : null,
                controller: controller.sectionController,
                decoration:
                    authInputDecoration(labelText: "اختر نوع المدرسة").copyWith(
                  suffixIcon: SizedBox(
                    child: controller.selectTypeWidget(
                      controller.sections,
                      controller.isLoadingSections,
                      "اختر نوع مدرستك",
                      context,
                      (newSection) async {
                        controller.sectionId = newSection.id;
                        controller.sectionController.text = newSection.name;
                        if (isTeacher) {
                          controller.subjectsId = "";
                          controller.subjectController.text = "";
                          await controller.getSubjects();
                        }
                      },
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.stageController,
                readOnly: true,
                onTap: () {},
                validator: (value) => value?.isEmpty ?? true
                    ? "اختر مرحلتك الدراسيه من فضلك"
                    : null,
                decoration:
                    authInputDecoration(labelText: "اختر المرحلة الدراسية")
                        .copyWith(
                  suffixIcon: controller.selectTypeWidget(
                    controller.stages,
                    controller.isLoadingStages,
                    "اختر مرحلتك الدراسية",
                    context,
                    (newStage) async {
                      controller.stageId = newStage.id;
                      controller.stageController.text = newStage.name;

                      controller.gradeId = "";
                      controller.gradeController.text = "";
                      if (isTeacher) {
                        controller.subjectsId = "";
                        controller.subjectController.text = "";
                        controller.subjects.clear();
                      }
                      await controller.getGrades();
                    },
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.gradeController,
                readOnly: true,
                onTap: () {},
                validator: (value) =>
                    value?.isEmpty ?? true ? "اختر صفك الدراسي من فضلك" : null,
                decoration: authInputDecoration(labelText: "اختر الصف الدراسي")
                    .copyWith(
                  suffixIcon: controller.selectTypeWidget(
                    controller.grades,
                    controller.isLoadingGrades,
                    "اختر صفك الدراسي",
                    context,
                    (newGrade) async {
                      controller.gradeId = newGrade.id;
                      controller.gradeController.text = newGrade.name;
                      if (isTeacher) {
                        controller.subjectsId = "";
                        controller.subjectController.text = "";
                        await controller.getSubjects();
                      }
                    },
                  ),
                ),
              ),
            ),
            if (isTeacher)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.subjectController,
                  readOnly: true,
                  validator: (value) => controller.selectedSubjects.isEmpty
                      ? "اختر المواد من فضلك"
                      : null,
                  decoration:
                      authInputDecoration(labelText: "اختر المواد التي تدرسها")
                          .copyWith(
                    suffixIcon: controller.selectTypeWidget(
                      controller.subjects,
                      controller.isLoadingSubjects,
                      "اختر المواد",
                      context,
                      (newSubject) async {
                        (newSubject as Subject).isChosen.value =
                            !newSubject.isChosen.value;
                        newSubject.isChosen.value
                            ? controller.selectedSubjects
                                .putIfAbsent(newSubject.id, () => newSubject)
                            : controller.selectedSubjects.remove(newSubject.id);
                      },
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
