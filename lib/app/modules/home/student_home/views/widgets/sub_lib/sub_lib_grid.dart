import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/student_home_controller.dart';
import 'sub_lib_grid_item.dart';

class SubLibGrid extends GetView<StudentHomeController> {
  const SubLibGrid(this.isSub, {super.key});
  final bool isSub;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(4),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.5 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: min(
          6,
          isSub ? controller.subjects.length : controller.libraries.length,
        ),
        itemBuilder: (_, i) {
          return isSub
              ? SubLibGridItem(subject: controller.subjects[i])
              : SubLibGridItem(library: controller.libraries[i]);
        },
      ),
    );
  }
}
