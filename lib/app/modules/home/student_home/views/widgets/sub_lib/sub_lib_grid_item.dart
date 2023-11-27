import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/constants/styles/colors.dart';
import '../../../../../../data/models/library.dart';
import '../../../../../../data/models/subject.dart';
import '../../../controllers/student_home_controller.dart';
import '../../screens/units_screen.dart';

class SubLibGridItem extends GetView<StudentHomeController> {
  const SubLibGridItem({this.subject, this.library, super.key});
  final Subject? subject;
  final Library? library;

  @override
  Widget build(BuildContext context) {
    final bool isSub;
    if (subject == null && library != null) {
      isSub = false;
    } else if (subject != null && library == null) {
      isSub = true;
    } else {
      throw Exception("must insert only sub or lib");
    }
    return GestureDetector(
      onTap: () async {
        isSub ? await subject!.getUnits(controller.user.token!) : null;
        Get.to(UnitsScreen(subject!));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: infoColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  topLeft: Radius.circular(15.r),
                ),
              ),
              key: UniqueKey(),
              child: isSub
                  ? subject!.image == null
                      ? Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Image.asset("assets/subject.png"),
                        )
                      : FadeInImage(
                          placeholder: const AssetImage("assets/subject.png"),
                          image: NetworkImage(subject!.image!),
                          fit: BoxFit.fill,
                        )
                  : library!.image == null
                      ? Image.asset("assets/library.png")
                      : FadeInImage(
                          placeholder: const AssetImage("assets/library.png"),
                          image: NetworkImage(library!.image!),
                        ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2.w, color: infoColor),
              boxShadow: [
                BoxShadow(
                  offset: Offset(10.w, 10.h),
                  blurRadius: 20.r,
                  color: Colors.black45,
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r),
              ),
            ),
            width: double.infinity,
            child: Center(
              child: DefaultTextStyle(
                style: TextStyle(
                  color: infoColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                softWrap: false,
                overflow: TextOverflow.fade,
                child: Text(
                  subject?.name ?? library!.name,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
