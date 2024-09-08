
class GetOccupationsModel {
  int? code;
  List<Datum>? data;
  String? msg;

  GetOccupationsModel({
    this.code,
    this.data,
    this.msg,
  });

  factory GetOccupationsModel.fromJson(Map<String, dynamic> json) => GetOccupationsModel(
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

  Datum({
    this.id,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
