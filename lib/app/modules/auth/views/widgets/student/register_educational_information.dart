import 'package:flutter/material.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/models/register_model.dart';
import '../../../../../shared/styles/text_styles.dart';
import '../../../controllers/register_controller.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../shared/styles/text_field_styles.dart';

class RegisterEducationalInformation extends GetView<RegisterController> {
  const RegisterEducationalInformation({this.isTeacher = false, super.key});
  final bool isTeacher;
  @override
  Widget build(BuildContext context) {
    void showRegisterListBottomSheet(registerList, onSelectedFun) {
      if (registerList.isEmpty) {
        Get.closeCurrentSnackbar();
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
        builder: (_) => ListView.builder(
          shrinkWrap: true,
          itemCount: registerList.length,
          itemBuilder: (context, index) {
            final Register type = registerList[index];
            return Column(
              children: [
                if (index != 0)
                  const Divider(
                    color: primaryColor,
                    thickness: 2,
                  ),
                TextButton(
                  onPressed: () {
                    onSelectedFun(type);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: primaryButtonColor.withBlue(100),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                  ),
                  child: SizedBox(
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
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    controller.getSections();
    controller.getStages();

    Widget selectTypeWidget(
      List<Register> registerList,
      RxBool isLoading,
      void Function(Register newValue) onSelectedFun,
    ) {
      final double pageWidth = Get.size.width;
      return Obx(
        () => isLoading.value
            ? const Padding(
                padding: EdgeInsets.all(10.0),
                child: CircularProgressIndicator.adaptive(),
              )
            : IconButton(
                key: key,
                onPressed: () =>
                    showRegisterListBottomSheet(registerList, onSelectedFun),
                icon: SizedBox(
                  width: pageWidth - 20,
                  height: 100,
                  child: Icon(
                    Icons.arrow_drop_down_sharp,
                    color: registerList.isEmpty ? Colors.grey : primaryColor,
                  ),
                ),
                color: primaryButtonColor,
              ),
      );
    }

    return Center(
      child: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // get section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  onTap: () {},
                  validator: (value) =>
                      value?.isEmpty ?? true ? "اختر نوع مدرستك من فضلك" : null,
                  controller: controller.sectionController,
                  decoration: authInputDecoration(labelText: "اختر نوع المدرسة")
                      .copyWith(
                    suffixIcon: SizedBox(
                      child: selectTypeWidget(
                        controller.sections,
                        controller.isLoadingSections,
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
                    decoration: authInputDecoration(
                            labelText: "اختر المواد التي تدرسها")
                        .copyWith(
                      suffixIcon: selectTypeWidget(
                        controller.subjects,
                        controller.isLoadingSubjects,
                        (newSubject) async {
                          controller.subjectsId = newSubject.id;
                          controller.subjectController.text = newSubject.name;
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
