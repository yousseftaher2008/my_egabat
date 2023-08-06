import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/text_styles.dart';
import '../../models/register_model.dart';
import '../../models/subject_model.dart';
import '../state_management/register_controller.dart';

class RegisterEduController extends RegisterController {
  bool _isSnackBarOpen = false;
  Widget selectTypeWidget(List registerList, RxBool isLoading, String title,
      BuildContext context, void Function(Register newValue) onSelectedFun,
      [bool isSubjects = false]) {
    return IconButton(
      onPressed: () => showRegisterListBottomSheet(
        registerList,
        onSelectedFun,
        title,
        context,
        isSubjects: isSubjects,
      ),
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
          isShowSubjects ? "لا يوجد مواد" : "لا يوجد اختيارات ",
          style: welcomeTitleTextStyle.copyWith(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        messageText: Text(
          isShowSubjects
              ? "انت لم تختر المواد التي تدرسها, يرجى اختيار المواد اولا"
              : "الخانه الدراسيه السابقه لهذه الخانه فارغه او انك لم تختر شئ من الخانه السابقة",
          style: welcomeBodyTextStyle,
          textAlign: TextAlign.center,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryButtonColor,
        margin: const EdgeInsets.all(10),
      );
      Future.delayed(const Duration(seconds: 3), () {
        _isSnackBarOpen = false;
      });
      return;
    } else if (itemsList.isEmpty) {
      return;
    }
    Get.closeCurrentSnackbar();
    const BorderRadius borderRadiusShape = BorderRadius.only(
      topRight: Radius.circular(30),
      topLeft: Radius.circular(30),
    );

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: borderRadiusShape),
      backgroundColor: primaryButtonColor,
      builder: (_) {
        ListView listView(List items) => ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                Widget itemWidget = SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      item.name,
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
                              onPressed: () => onSelectedFun(item),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white.withOpacity(0.3),
                                backgroundColor:
                                    (item as Subject).isChosen.value
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
            ClipRRect(
              borderRadius: borderRadiusShape,
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(title, style: welcomeTitleTextStyle),
                  ),
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: pageHeight / 2 - 100),
              child: isShowSubjects
                  ? Obx(
                      () => listView(
                        selectedSubjects.values.toList(),
                      ),
                    )
                  : listView(itemsList),
            ),
          ],
        );
      },
    );
  }
}
