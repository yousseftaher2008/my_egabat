import 'package:get/get.dart';

import 'register_model.dart';

class AuthSubject extends Register {
  final RxBool isChosen = false.obs;
  late final String fullName;
  AuthSubject({
    required super.id,
    required super.name,
    required this.fullName,
  });
  factory AuthSubject.fromJson(Map<String, dynamic> json) {
    return AuthSubject(
      id: json["subjectId"],
      name: json["subjectName"],
      fullName:
          "${json["subjectName"]} / ${json["stageName"]} / ${json["gradeName"]}",
    );
  }
}
