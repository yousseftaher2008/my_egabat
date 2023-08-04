import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/models/register_model.dart';

class Subject extends Register {
  final RxBool isChosen = false.obs;

  Subject({
    required super.id,
    required super.name,
  });
}
