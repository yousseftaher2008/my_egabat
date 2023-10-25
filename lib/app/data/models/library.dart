import '../../core/constants/base_url.dart';

class Library {
  String? name, filePath;

  Library(this.name, this.filePath);

  Library.fromJson(Map<String, dynamic> json) {
    filePath =
        (json["image"]?.isNotEmpty ?? false) ? imageUrl + json["image"]! : null;
    name = json["name"];
  }
}
