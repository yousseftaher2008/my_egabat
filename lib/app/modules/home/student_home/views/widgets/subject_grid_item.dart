import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/styles/colors.dart';
import '../../../../../core/constants/styles/text_styles.dart';
import '../../../../../data/models/searched_subjects.dart';
import '../screens/pdf_viewer_screen.dart';

class SearchedSubjectGridItem extends StatelessWidget {
  const SearchedSubjectGridItem(this.subject, {super.key});
  final SearchedSubject subject;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          PdfViewerPage(subject),
        );
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
              child: Image.asset(
                "assets/file_image.png",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: h4RegularInfo,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  child: Text(
                    subject.name,
                  ),
                ),
                // DefaultTextStyle(
                //   style: TextStyle(
                //     color: infoColor.withOpacity(0.75),
                //     fontWeight: FontWeight.bold,
                //   ),
                //   softWrap: false,
                //   overflow: TextOverflow.ellipsis,
                //   child: const Text(
                //     "pages: 3",
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
