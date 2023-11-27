import 'lesson.dart';

class Unit {
  late final String id, name, semester;
  late final String? url;
  List<Lesson> lessons = [];

  Unit.fromJson(json) {
    id = json["unitId"];
    name = json["unitName"];
    url = json["unitURL"];
    semester = json["semester"];
    for (final lesson in json["lessons"]) {
      lessons.add(Lesson.fromJson(lesson));
    }
  }
}
