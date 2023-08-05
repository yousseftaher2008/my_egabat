import 'package:get/get.dart';
import 'register_model.dart';

//TODO: add full name property and formJson method
class Subject extends Register {
  final RxBool isChosen = false.obs;
  int? indexInList;

  Subject({
    required super.id,
    required super.name,
  });
}
