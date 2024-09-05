
class VerificationModel {
  int? code;
  VerificationModelData? data;
  String? msg;

  VerificationModel({
    this.code,
    this.data,
    this.msg,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) => VerificationModel(
    code: json["code"],
    data: json["data"] == null ? null : VerificationModelData.fromJson(json["data"]),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
    "msg": msg,
  };
}

class VerificationModelData {
  int? code;
  DataData? data;
  String? msg;

  VerificationModelData({
    this.code,
    this.data,
    this.msg,
  });

  factory VerificationModelData.fromJson(Map<String, dynamic> json) => VerificationModelData(
    code: json["code"],
    data: json["data"] == null ? null : DataData.fromJson(json["data"]),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
    "msg": msg,
  };
}

class DataData {
  String? username;
  String? password;
  String? clientId;

  DataData({
    this.username,
    this.password,
    this.clientId,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    username: json["username"],
    password: json["password"],
    clientId: json["client_id"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "client_id": clientId,
  };
}
