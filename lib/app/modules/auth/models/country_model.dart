class Country {
  late String id;
  late String name;
  late String code;
  late String flag;
  late String isoCode;

  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.flag,
  }) {
    if (code == "+2") {
      isoCode = "EG";
    } else if (code == "+965") {
      isoCode = "KW";
    }
    print("$code $isoCode");
  }

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    code = json['code'] ?? "";
    flag = json['flag'] ?? "";
    if (code == "+2") {
      isoCode = "EG";
    } else if (code == "+965") {
      isoCode = "KW";
    }
    print("$code $isoCode");
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['flag'] = flag;
    return data;
  }
}
