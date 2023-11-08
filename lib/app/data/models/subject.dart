import '../../core/constants/base_url.dart';

class Subject {
  late String id, name;
  late String? image;
  late double price;
  late bool isFree, isSubscribed;

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
}
