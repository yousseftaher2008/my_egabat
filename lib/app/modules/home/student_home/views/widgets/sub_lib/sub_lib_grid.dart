import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/student_home_controller.dart';
import 'sub_lib_grid_item.dart';

class SubLibGrid extends GetView<StudentHomeController> {
  const SubLibGrid(this.isSub, {this.isFull = false, super.key});
  final bool isSub;
  final bool isFull;

  @override
  Widget build(BuildContext context) {
    final int fullLength =
        isSub ? controller.subjects.length : controller.libraries.length;
    final double spacing = isFull ? 20 : 10;
    return Padding(
      padding: EdgeInsets.only(
        bottom: isSub && !isFull ? 30.0.h : 0,
        right: 4.w,
        left: 4.w,
      ),
      child: GridView.builder(
        // scrollDirection: Axis.horizontal,
        physics: isFull ? null : const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isFull ? 2 : 3,
          childAspectRatio: .75,
          crossAxisSpacing: spacing.h,
          mainAxisSpacing: spacing.w,
        ),
        itemCount: isFull || fullLength < 6 ? fullLength : 6,
        itemBuilder: (_, i) {
          return isSub
              ? SubLibGridItem(subject: controller.subjects[i])
              : SubLibGridItem(library: controller.libraries[i]);
        },
      ),
    );
  }
}
