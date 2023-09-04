import 'dart:io';

import 'user.dart';

class Student extends User {
  File? studentImage;

  Student({
    required super.token,
    required super.id,
    required super.phone,
  });
}
