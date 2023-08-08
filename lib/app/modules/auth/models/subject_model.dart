import 'package:get/get.dart';
import 'register_model.dart';

class Subject extends Register {
  final RxBool isChosen = false.obs;
  late final String fullName;
  final Map jsonSubject;
  Subject({
    required super.id,
    required super.name,
    required String gradeName,
    required String stageName,
    required this.jsonSubject,
  }) {
    fullName = "$name / $stageName / $gradeName";
  }
}
