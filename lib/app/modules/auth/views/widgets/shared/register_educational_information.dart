// TODO: see the chosen subjects
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/models/register_model.dart';
import '../../../../../shared/styles/text_styles.dart';
import '../../../controllers/register_controller.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../shared/styles/text_field_styles.dart';
import '../../../models/subject_model.dart';

class RegisterEducationalInformation extends GetView<RegisterController> {
  const RegisterEducationalInformation({this.isTeacher = false, super.key});
  final bool isTeacher;
  @override
  Widget build(BuildContext context) {
    bool isSnackBarOpen = false;
    void showRegisterListBottomSheet(
        registerList, onSelectedFun, bool isSubjects, String title) {
      Get.closeCurrentSnackbar();
      if (registerList.isEmpty && !isSnackBarOpen) {
        isSnackBarOpen = true;
        Get.snackbar(
          "",
          "",
          titleText: Text(
            "لا يوجد اختيارات ",
            style: welcomeTitleTextStyle.copyWith(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          messageText: const Text(
            "الخانه الدراسيه السابقه لهذه الخانه فارغه او انك لم تختر شئ من الخانه السابقة",
            style: welcomeBodyTextStyle,
            textAlign: TextAlign.center,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryButtonColor,
          margin: const EdgeInsets.all(10),
        );
        Future.delayed(const Duration(seconds: 3), () {
          isSnackBarOpen = false;
        });
        return;
      } else if (registerList.isEmpty) {
        return;
      }
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        backgroundColor: primaryButtonColor,
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "اختر $title",
                      style: welcomeTitleTextStyle,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // height: Get.size.height / 2 - 100,
              constraints: BoxConstraints(maxHeight: Get.size.height / 2 - 100),
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemCount: registerList.length,
                itemBuilder: (context, index) {
                  final type = registerList[index];
                  Widget textButtonChild = SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        type.name,
                        style: welcomeTitleTextStyle.copyWith(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );

                  return Column(
                    children: [
                      const ColoredBox(
                        color: primaryColor,
                        child: SizedBox(
                          height: 2,
                          width: double.infinity,
                        ),
                      ),
                      isSubjects
                          ? Obx(
                              () => TextButton(
                                onPressed: () {
                                  (type as Subject).isChosen.value =
                                      !type.isChosen.value;
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      Colors.white.withOpacity(0.3),
                                  backgroundColor: type.isChosen.value == true
                                      ? Colors.white.withOpacity(0.3)
                                      : null,
                                  // padding: const EdgeInsets.all(10),
                                ),
                                child: textButtonChild,
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                onSelectedFun(type);
                                Navigator.of(context).pop();
                              },
                              child: textButtonChild,
                            ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    controller.getSections();
    controller.getStages();

    Widget selectTypeWidget(List registerList, RxBool isLoading, String title,
        void Function(Register newValue) onSelectedFun,
        [bool isSubjects = false]) {
      final double pageWidth = Get.size.width;
      return IconButton(
        key: key,
        onPressed: () => showRegisterListBottomSheet(
            registerList, onSelectedFun, isSubjects, title),
        icon: SizedBox(
          width: pageWidth - 20,
          height: 100,
          child: Obx(
            () => Icon(
              Icons.arrow_drop_down_sharp,
              color: isLoading.value || registerList.isEmpty
                  ? Colors.grey
                  : primaryColor,
            ),
          ),
        ),
      );
    }

    return Center(
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Obx(
                () => controller.isLoadingGrades.value ||
                        controller.isLoadingSections.value ||
                        controller.isLoadingStages.value ||
                        controller.isLoadingSubjects.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox(),
              ),
            ),
            // get section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                readOnly: true,
                onTap: () {},
                validator: (value) =>
                    value?.isEmpty ?? true ? "اختر نوع مدرستك من فضلك" : null,
                controller: controller.sectionController,
                decoration:
                    authInputDecoration(labelText: "اختر نوع المدرسة").copyWith(
                  suffixIcon: SizedBox(
                    child: selectTypeWidget(
                      controller.sections,
                      controller.isLoadingSections,
                      "نوع مدرستك",
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
                  suffixIcon: selectTypeWidget(
                    controller.stages,
                    controller.isLoadingStages,
                    "مرحلتك الدراسية",
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
                  suffixIcon: selectTypeWidget(
                    controller.grades,
                    controller.isLoadingGrades,
                    "صفك الدراسي",
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
                  onTap: () {},
                  validator: (value) =>
                      value?.isEmpty ?? true ? "اختر المواد من فضلك" : null,
                  decoration:
                      authInputDecoration(labelText: "اختر المواد التي تدرسها")
                          .copyWith(
                    suffixIcon: selectTypeWidget(
                      controller.subjects,
                      controller.isLoadingSubjects,
                      "المواد",
                      (newSubject) async {
                        controller.subjectsId = newSubject.id;
                        controller.subjectController.text = newSubject.name;
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
