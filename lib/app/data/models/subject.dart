class Subject {
  String? name, filePath;

  Subject(this.name, this.filePath);

  Subject.fromJson(json) {
    filePath = json["image"];
    name = json["name"];
  }
}
