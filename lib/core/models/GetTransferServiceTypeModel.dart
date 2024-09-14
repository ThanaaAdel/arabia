
class GetTransferServiceTypeModel {
  int? code;
  List<Datum>? data;
  String? msg;

  GetTransferServiceTypeModel({
    this.code,
    this.data,
    this.msg,
  });

  factory GetTransferServiceTypeModel.fromJson(Map<String, dynamic> json) => GetTransferServiceTypeModel(
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

  Datum({
    this.id,
    this.title,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
