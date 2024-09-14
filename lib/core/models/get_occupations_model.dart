
class GetOccupationsModel {
  int? code;
  List<GetOccupationsData>? data;
  String? msg;

  GetOccupationsModel({
    this.code,
    this.data,
    this.msg,
  });

  factory GetOccupationsModel.fromJson(Map<String, dynamic> json) => GetOccupationsModel(
    code: json["code"],
    data: json["data"] == null ? [] : List<GetOccupationsData>.from(json["data"]!.map((x) => GetOccupationsData.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class GetOccupationsData {
  String? id;
  String? name;

  GetOccupationsData({
    this.id,
    this.name,
  });

  factory GetOccupationsData.fromJson(Map<String, dynamic> json) => GetOccupationsData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
