import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";

import '../../../controllers/state_management/register_controller.dart';

class ImageInput extends GetView<RegisterController> {
  const ImageInput({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterController registerController = Get.find<RegisterController>();
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Obx(
            () => registerController.storedImage.value != null
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        FileImage(registerController.storedImage.value!),
                    backgroundColor: Colors.transparent,
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/user.png"),
                  ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.photo_camera),
                  onPressed: () {
                    controller.takePicture(ImageSource.camera);
                  },
                  label: Text("الكاميرا".tr),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    controller.takePicture(ImageSource.gallery);
                  },
                  label: Text("معرض الصور".tr),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
