import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'register_controller.dart';

class ImageInputController extends GetxController {
  Future<void> takePicture(
    ImageSource source,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (photo != null) {
      final File imageFile = File(photo.path);

      Get.find<RegisterController>().storedImage.value = imageFile;
    }
  }
}
