import 'package:get/get.dart';

import '../controllers/student_search_controller.dart';
import '../controllers/student_home_controller.dart';

class StudentHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentHomeController>(
      () => StudentHomeController(),
    );
    Get.lazyPut<StudentSearchController>(
      () => StudentSearchController(),
    );
  }
}
