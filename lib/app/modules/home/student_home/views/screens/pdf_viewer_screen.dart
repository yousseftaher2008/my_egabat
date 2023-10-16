import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/data/models/searched_subjects.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatelessWidget {
  const PdfViewerPage(this.subject, {super.key});
  final SearchedSubject subject;
  @override
  Widget build(BuildContext context) {
    PdfViewerController controller = PdfViewerController();
    final RxInt pageIndex = 1.obs;
    return Scaffold(
      appBar: AppBar(
        title: DefaultTextStyle(
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          child: Text(subject.name),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (pageIndex.value == 1) {
                controller.lastPage();
              } else {
                controller.previousPage();
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Obx(
                () => Text(
                  pageIndex.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (pageIndex.value == controller.pageCount) {
                controller.firstPage();
              } else {
                controller.nextPage();
              }
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      body: SfPdfViewer.network(
        subject.filePath,
        controller: controller,
        onPageChanged: (details) {
          pageIndex.value = details.newPageNumber;
        },
      ),
    );
  }
}
