import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/visitor_home_controller.dart';

class VisitorHomeView extends GetView<VisitorHomeController> {
  const VisitorHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VisitorHomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VisitorHomeView is working',
        ),
      ),
    );
  }
}
