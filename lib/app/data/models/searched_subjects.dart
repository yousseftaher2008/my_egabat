import 'dart:convert' as convert;

import 'package:my_egabat/app/core/constants/base_url.dart';

class SearchedSubject {
  late final String name, filePath;

  SearchedSubject.fromJson(json) {
    json = jsonDecoder(convert.json.encode(json));
    name = json["file_name"];
    filePath = imageUrl + json["file_path"];
  }
  Map<String, String> jsonDecoder(String str) {
    int nf = str.indexOf(':');
    int lf = str.lastIndexOf(':');

    final Map<String, String> map = {};
    map.putIfAbsent("file_name", () => str.substring(nf + 2, lf - 13));
    map.putIfAbsent("file_path", () => str.substring(lf + 2, str.length - 2));
    return map;
  }
}
