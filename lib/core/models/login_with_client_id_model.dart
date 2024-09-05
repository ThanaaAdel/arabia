
class LoginWithClientIdModel {
  int? code;
  Data? data;
  String? msg;

  LoginWithClientIdModel({
    this.code,
    this.data,
    this.msg,
  });

  factory LoginWithClientIdModel.fromJson(Map<String, dynamic> json) => LoginWithClientIdModel(
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
  String? clientId;
  String? sessionToken;

  Data({
    this.clientId,
    this.sessionToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    clientId: json["client_id"],
    sessionToken: json["session_token"],
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "session_token": sessionToken,
  };
}
