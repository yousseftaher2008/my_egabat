import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/screen_dimensions.dart';
import '../../../../core/constants/styles/colors.dart';
import '../../../../core/constants/styles/text_styles.dart';
import '../../models/register_model.dart';
import '../../models/subject_model.dart';
import '../state_management/register_controller.dart';

class RegisterEduController extends GetxController {
  final RegisterController _registerController = Get.find<RegisterController>();
  bool _isSnackBarOpen = false;
  Widget selectTypeWidget(List registerList, String title, BuildContext context,
      RxBool isLoading, void Function(Register newValue) onSelectedFun,
      [bool isSubjects = false]) {
    return IconButton(
      onPressed: () => showRegisterListBottomSheet(
        registerList,
        onSelectedFun,
        title,
        context,
        isSubjects: isSubjects,
      ),
      icon: Obx(
        () => Icon(
          Icons.arrow_drop_down_sharp,
          color: isLoading.value || registerList.isEmpty
              ? Colors.grey
              : primaryColor,
        ),
      ),
    );
  }

  void showRegisterListBottomSheet(
      List itemsList,
      void Function(Register item) onSelectedFun,
      String title,
      BuildContext context,
      {bool isSubjects = false,
      bool isShowSubjects = false}) {
    if (itemsList.isEmpty && !_isSnackBarOpen) {
      _isSnackBarOpen = true;
      Get.snackbar(
        "",
        "",
        titleText: Text(
          isShowSubjects ? "لا يوجد مواد".tr : "لا يوجد اختيارات".tr,
          style: welcomeTitleTextStyle.copyWith(fontSize: 25.sp),
          textAlign: TextAlign.center,
        ),
        messageText: Text(
          isShowSubjects
              ? "انت لم تختر المواد التي تدرسها, يرجى اختيار المواد اولا".tr
              : "الخانه الدراسيه السابقه لهذه الخانه فارغه او انك لم تختر شئ من الخانه السابقة"
                  .tr,
          style: welcomeBodyTextStyle,
          textAlign: TextAlign.center,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryButtonColor,
        margin: EdgeInsets.all(10.sp),
      );
      Future.delayed(const Duration(seconds: 3), () {
        _isSnackBarOpen = false;
      });
      return;
    } else if (itemsList.isEmpty) {
      return;
    }
    Get.closeCurrentSnackbar();
    BorderRadius borderRadiusShape = BorderRadius.only(
      topRight: Radius.circular(30.r),
      topLeft: Radius.circular(30.r),
    );

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: borderRadiusShape),
      backgroundColor: primaryButtonColor,
      builder: (_) {
        ListView listView(int length) => ListView.builder(
              shrinkWrap: true,
              itemCount: length,
              itemBuilder: (context, index) {
                final Register item = isShowSubjects
                    ? _registerController.selectedSubjects.values
                        .elementAt(index)
                    : itemsList[index];
                Widget itemWidget = SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(15.0.sp),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            isShowSubjects
                                ? (item as AuthSubject).fullName
                                : item.name,
                            style: welcomeTitleTextStyle.copyWith(
                              fontSize: 20.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (isShowSubjects)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () => onSelectedFun(item),
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          )
                      ],
                    ),
                  ),
                );

                return Column(
                  children: [
                    if (index != 0)
                      ColoredBox(
                        color: primaryColor,
                        child: SizedBox(
                          height: 2.h,
                          width: double.infinity,
                        ),
                      ),
                    isSubjects
                        ? Obx(
                            () => TextButton(
                              onPressed: () => onSelectedFun(item),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white.withOpacity(0.3),
                                backgroundColor:
                                    (item as AuthSubject).isChosen.value
                                        ? Colors.white.withOpacity(0.3)
                                        : null,
                              ),
                              child: itemWidget,
                            ),
                          )
                        : isShowSubjects
                            ? Dismissible(
                                key: GlobalKey(),
                                background: const ColoredBox(
                                  color: Colors.red,
                                  child: SizedBox(width: double.infinity),
                                ),
                                onDismissed: (_) => onSelectedFun(item),
                                child: itemWidget,
                              )
                            : TextButton(
                                onPressed: () {
                                  onSelectedFun(item);
                                  Navigator.of(context).pop();
                                },
                                child: itemWidget,
                              ),
                  ],
                );
              },
            );

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100.h,
              width: double.infinity,
              padding: EdgeInsets.all(8.0.sp),
              decoration: BoxDecoration(
                borderRadius: borderRadiusShape,
              ),
              child: isShowSubjects
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            _registerController.selectedSubjects.clear();
                            for (var subject in _registerController.subjects) {
                              subject.isChosen.value = false;
                            }
                            Get.back();
                          },
                          child: Text(
                            "مسح الكل".tr,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        Center(
                          child: Text(title, style: welcomeTitleTextStyle),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(title, style: welcomeTitleTextStyle),
                    ),
            ),
            const ColoredBox(
              color: primaryColor,
              child: SizedBox(
                height: 2,
                width: double.infinity,
              ),
            ),
            Container(
              constraints:
                  BoxConstraints(maxHeight: (pageWidth() / 2 - 150).sp),
              child: isShowSubjects
                  ? Obx(
                      () {
                        if (_registerController.selectedSubjectsLength.value ==
                            0) {
                          Get.back();
                        }
                        return listView(
                            _registerController.selectedSubjectsLength.value);
                      },
                    )
                  : listView(itemsList.length),
            )
          ],
        );
      },
    );
  }

  void Function(Register item) selectSection(bool isTeacher) =>
      (Register newSection) async {
        bool isSame = newSection.id == _registerController.sectionId;
        _registerController.sectionId = newSection.id;
        _registerController.sectionController.text = newSection.name;
        if (_registerController.isTeacher.value && isSame) {
          _registerController.getSubjects();
        }
      };

  void selectStage(Register newStage) async {
    bool isSame = _registerController.stageId == newStage.id;
    _registerController.stageId = newStage.id;
    _registerController.stageController.text = newStage.name;
    if (!isSame) {
      _registerController.gradeId = "";
      _registerController.gradeController.text = "";
      await _registerController.getGrades();
    }
  }

  void Function(Register item) selectGrade(bool isTeacher) {
    return (Register newGrade) async {
      bool isSame = _registerController.gradeId == newGrade.id;
      _registerController.gradeId = newGrade.id;
      _registerController.gradeController.text = newGrade.name;
      if (isTeacher && !isSame) {
        await _registerController.getSubjects();
      }
    };
  }

  void selectSubject(Register newSubject) {
    (newSubject as AuthSubject).isChosen.value = !newSubject.isChosen.value;
    newSubject.isChosen.value
        ? _registerController.selectedSubjects
            .putIfAbsent(newSubject.id, () => newSubject)
        : _registerController.selectedSubjects.remove(newSubject.id);
    _registerController.updateSelectedSubjectsLength();
  }
}
