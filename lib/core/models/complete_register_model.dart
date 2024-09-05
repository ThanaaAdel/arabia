
class CompleteRegisterModel {
  int? code;
  Data? data;
  String? msg;

  CompleteRegisterModel({
    this.code,
    this.data,
    this.msg,
  });

  factory CompleteRegisterModel.fromJson(Map<String, dynamic> json) => CompleteRegisterModel(
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
    "msg": msg,
  };
}

class Data {
  String? username;
  String? password;
  int? clientId;

  Data({
    this.username,
    this.password,
    this.clientId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
