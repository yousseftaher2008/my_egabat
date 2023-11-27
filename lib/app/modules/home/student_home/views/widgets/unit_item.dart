import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/screen_dimensions.dart';
import '../../../../../core/constants/styles/colors.dart';
import '../../../../../data/models/unit.dart';

class UnitItem extends StatelessWidget {
  const UnitItem(this.unit, {super.key});

  final Unit unit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Row(
        children: [
          ColoredBox(
            color: infoColor,
            child: Image.asset(
              "assets/unit.png",
              width: pageWidth() / 3,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  unit.name,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
