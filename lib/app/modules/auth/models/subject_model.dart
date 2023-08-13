import 'package:get/get.dart';

import 'register_model.dart';

class Subject extends Register {
  final RxBool isChosen = false.obs;
  late final String fullName;
  Subject({
    required super.id,
    required super.name,
    required this.fullName,
  });
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json["subjectId"],
      name: json["subjectName"],
      fullName:
          "${json["subjectName"]} / ${json["stageName"]} / ${json["gradeName"]}",
    );
  }
}
