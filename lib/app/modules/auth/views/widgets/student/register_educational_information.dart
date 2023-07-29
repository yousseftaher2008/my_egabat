import 'package:flutter/material.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../../controllers/register_controller.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../shared/styles/text_field_styles.dart';
import '../../../../../shared/styles/text_styles.dart';

class RegisterEducationalInformation extends GetView<RegisterController> {
  const RegisterEducationalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final sectionKey = GlobalKey<PopupMenuButtonState>();
    final stageKey = GlobalKey<PopupMenuButtonState>();
    final gradeKey = GlobalKey<PopupMenuButtonState>();
    Widget selectTypeWidget(List typesList, RxBool isLoading,
        void Function(dynamic newValue) onSelectedFun,
        {required final GlobalKey<PopupMenuButtonState> key}) {
      final double pageWidth = Get.size.width;
      return Obx(
        () => isLoading.value
            ? const Padding(
                padding: EdgeInsets.all(10.0),
                child: CircularProgressIndicator.adaptive(),
              )
            : PopupMenuButton(
                key: key,
                icon: SizedBox(
                  // alignment: Alignment.centerLeft,
                  width: pageWidth - 20,
                  height: 100,
                  child: const Icon(
                    Icons.arrow_drop_down_sharp,
                  ),
                ),
                onSelected: onSelectedFun,
                color: primaryButtonColor,
                constraints:
                    BoxConstraints(maxHeight: 150, minWidth: pageWidth - 20),
                itemBuilder: (_) => (typesList)
                    .map(
                      (type) => PopupMenuItem(
                        value: type,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              type.name,
                              style: welcomeBodyTextStyle,
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
      );
    }

    return Expanded(
      child: Center(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              shrinkWrap: true,
              children: [
                // get section
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      sectionKey.currentState?.showButtonMenu();
                    },
                    validator: (value) => value?.isEmpty ?? true
                        ? "اختر نوع مدرستك من فضلك"
                        : null,
                    controller: controller.sectionController,
                    decoration:
                        authInputDecoration(labelText: "اختر نوع المدرسة")
                            .copyWith(
                      suffixIcon: SizedBox(
                        child: selectTypeWidget(
                          controller.sections,
                          controller.isLoadingSections,
                          (newSection) async {
                            controller.sectionId = newSection.id;
                            controller.sectionController.text = newSection.name;
                          },
                          key: sectionKey,
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
                    onTap: () {
                      stageKey.currentState?.showButtonMenu();
                    },
                    validator: (value) => value?.isEmpty ?? true
                        ? "اختر مرحلتك الدراسيه من فضلك"
                        : null,
                    decoration:
                        authInputDecoration(labelText: "اختر المرحلة الدراسية")
                            .copyWith(
                      suffixIcon: selectTypeWidget(
                        controller.stages,
                        controller.isLoadingStages,
                        (newStage) async {
                          controller.stageId = newStage.id;
                          controller.stageController.text = newStage.name;
                          controller.gradeId = "";
                          controller.gradeController.text = "";
                          await controller.getGrades();
                        },
                        key: stageKey,
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
                    onTap: () {
                      gradeKey.currentState?.showButtonMenu();
                    },
                    validator: (value) => value?.isEmpty ?? true
                        ? "اختر صفك الدراسي من فضلك"
                        : null,
                    decoration:
                        authInputDecoration(labelText: "اختر الصف الدراسي")
                            .copyWith(
                      suffixIcon: selectTypeWidget(
                        controller.grades,
                        controller.isLoadingGrades,
                        (newGrade) async {
                          controller.gradeId = newGrade.id;
                          controller.gradeController.text = newGrade.name;
                        },
                        key: gradeKey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
