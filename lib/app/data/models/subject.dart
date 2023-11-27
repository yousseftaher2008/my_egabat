import 'dart:convert';

import 'package:http/http.dart';

import '../../core/constants/base_url.dart';
import 'unit.dart';

class Subject {
  late String id, name;
  late String? image;
  late double price;
  late bool isFree, isSubscribed;
  List<Unit> units = [];

  bool _isUnitsGot = false;

  Subject(this.name, this.image);

  Subject.fromJson(json) {
    id = json["subjectId"] ?? "";
    name = json["subjectName"] ?? "";
    price = json["subjectPrice"];
    image =
        json["subjectImage"] == null ? null : imageUrl + json["subjectImage"];
    isFree = json["isFree"] ?? false;
    isSubscribed = json["isSubscriped"] ?? false;
  }

  Future<void> getUnits(String token) async {
    if (_isUnitsGot) return;
    _isUnitsGot = true;
    String url = '${baseUrl}Lesson/GetSubjectUnitsLessons/$id';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    final response = await get(Uri.parse(url), headers: headers);
    final List<dynamic> unitsJson = json.decode(response.body);
    for (final unit in unitsJson) {
      units.add(Unit.fromJson(unit));
    }
  }
}
