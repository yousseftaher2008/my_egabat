import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/styles/colors.dart';
import '../../controllers/student_search_controller.dart';
import '../widgets/sub_lib/sub_lib_grid.dart';

class SubLibScreen extends GetView<StudentSearchController> {
  const SubLibScreen(this.isSub, {super.key});
  final bool isSub;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: infoColor,
        title: Text(isSub ? "المواد".tr : "المكتبات".tr),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SubLibGrid(isSub, isFull: true),
          ),
        ],
      ),
    );
  }
}
