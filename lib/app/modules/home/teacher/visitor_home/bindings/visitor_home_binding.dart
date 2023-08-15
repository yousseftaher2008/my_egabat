import 'package:get/get.dart';

import '../controllers/visitor_home_controller.dart';

class VisitorHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitorHomeController>(
      () => VisitorHomeController(),
    );
  }
}
