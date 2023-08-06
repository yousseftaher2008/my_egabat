import 'package:get/get.dart';
import 'register_model.dart';

class Subject extends Register {
  final RxBool isChosen = false.obs;
  late final String fullName;
  Subject({
    required super.id,
    required super.name,
  });

  fromJson(Map<String, dynamic> json) {
    fullName = "$name / ${json['gradeName']} / ${json['subjectName']}";
  }
}
