import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:my_egabat/app/modules/auth/controllers/image_input_controller.dart";
import "package:my_egabat/app/modules/auth/controllers/register_controller.dart";

class ImageInput extends GetView<ImageInputController> {
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
                  label: const Text("الكاميرا"),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    controller.takePicture(ImageSource.gallery);
                  },
                  label: const Text("معرض الصور"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}