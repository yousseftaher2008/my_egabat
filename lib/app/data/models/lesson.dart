class Lesson {
  late final String id, name;
  late final String? url;
  late final bool isQuestions, isVideo, isPdf, isAudio;
  Lesson.fromJson(json) {
    id = json["lessonId"];
    name = json["lessonName"];
    url = json["lessonURL"];
    isQuestions = json["isQuestions"];
    isVideo = json["isVedio"];
    isPdf = json["isPdf"];
    isAudio = json["isAudio"];
  }
}
