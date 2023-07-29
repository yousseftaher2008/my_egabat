import 'package:get/get.dart';

import '../controllers/image_input_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageInputController>(
      () => ImageInputController(),
    );
  }
}
