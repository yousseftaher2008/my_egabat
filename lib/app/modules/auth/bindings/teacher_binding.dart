import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/teacher_controller.dart';

class TeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherController>(
      () => TeacherController(),
    );
  }
}
