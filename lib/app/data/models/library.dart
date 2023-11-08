import '../../core/constants/base_url.dart';

class Library {
  late String id, name;
  String? image;
  bool? general, isActive;
  Library(this.name, this.image);

  Library.fromJson(Map<String, dynamic> json) {
    id = json["mainCategory_Id"] ?? "";
    name = json["mainCategory_Name"] ?? "";
    image =
        (json["mainCategory_Image"] != null) ? imageUrl + json["image"]! : null;
    general = json["general"];
    isActive = json["isActive"];
  }
}
