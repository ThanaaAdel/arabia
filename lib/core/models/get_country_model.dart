
class GetCountriesModel {
  int? code;
  List<Datum>? data;
  String? msg;

  GetCountriesModel({
    this.code,
    this.data,
    this.msg,
  });

  factory GetCountriesModel.fromJson(Map<String, dynamic> json) => GetCountriesModel(
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
  String? name;
  String? internationalCode;

  Datum({
    this.id,
    this.name,
    this.internationalCode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    internationalCode: json["international_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "international_code": internationalCode,
  };
}
