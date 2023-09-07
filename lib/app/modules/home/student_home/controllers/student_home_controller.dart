import 'package:get/get.dart';
import 'package:my_egabat/app/data/models/student.dart';
import 'package:my_egabat/app/data/models/user.dart';
import 'package:my_egabat/app/modules/main/controllers/main_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../core/functions/get_student_profile.dart';

class StudentHomeController extends MainController {
  Student? currentStudent;
  final MainController mainController = Get.find<MainController>();
  late User currentUser;

  Future<void> getUser(userOrToken) async {
    if (userOrToken is Student) {
      currentStudent = userOrToken;
    } else if (userOrToken is String) {
      currentStudent = await getStudentProfile(userOrToken);
      mainController.user = User(
        userId: currentStudent!.studentId,
        token: mainController.user.token,
        userName: currentStudent!.name,
        userEmail: currentStudent!.email,
        userImage: currentStudent!.profileImage,
        isLogin: true,
        isTeacher: false,
        isVisitor: false,
      )..setData();
    }
    currentUser = mainController.user;
  }

  void checkQrCode(QRViewController qrController) {
    qrController.scannedDataStream.listen((Barcode event) {
      if (event.code != null) {
        Get.back();
      }
    });
  }
}
