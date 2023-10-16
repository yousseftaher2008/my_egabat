import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/home/student_home/views/screens/pdf_viewer_screen.dart';

import '../../../../../data/models/searched_subjects.dart';
import '../../../../../core/constants/styles/colors.dart';

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
              decoration: const BoxDecoration(
                color: infoColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              key: UniqueKey(),
              child: Image.asset(
                "assets/file_image.png",
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: infoColor),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(10, 10),
                  blurRadius: 20,
                  color: Colors.black45,
                ),
              ],
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(
                    color: infoColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
