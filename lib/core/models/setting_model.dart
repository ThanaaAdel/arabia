
class SettingModel {
  int? code;
  List<Datum>? data;
  String? msg;

  SettingModel({
    this.code,
    this.data,
    this.msg,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    code: json["code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class Datum {
  String? id;
  String? title;
  String? content;
  String? systemCategory;

  Datum({
    this.id,
    this.title,
    this.content,
    this.systemCategory,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    systemCategory: json["system_category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "system_category": systemCategory,
  };
}
