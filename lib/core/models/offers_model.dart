
class OffersModel {
  int? code;
  List<OffersData>? data;
  String? msg;

  OffersModel({
    this.code,
    this.data,
    this.msg,
  });

  factory OffersModel.fromJson(Map<String, dynamic> json) => OffersModel(
    code: json["code"],
    data: json["data"] == null ? [] : List<OffersData>.from(json["data"]!.map((x) => OffersData.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class OffersData {
  String? id;
  String? application;
  String? group;
  String? preventRemove;
  String? title;
  String? content;
  String? systemCategory;

  OffersData({
    this.id,
    this.application,
    this.group,
    this.preventRemove,
    this.title,
    this.content,
    this.systemCategory,
  });

  factory OffersData.fromJson(Map<String, dynamic> json) => OffersData(
    id: json["id"],
    application: json["application"],
    group: json["_group"],
    preventRemove: json["prevent_remove"],
    title: json["title"],
    content: json["content"],
    systemCategory: json["system_category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "application": application,
    "_group": group,
    "prevent_remove": preventRemove,
    "title": title,
    "content": content,
    "system_category": systemCategory,
  };
}
