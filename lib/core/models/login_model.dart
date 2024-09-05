
class LoginModel {
  int? code;
  Data? data;
  String? msg;

  LoginModel({
    this.code,
    this.data,
    this.msg,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  String? token;
  int? confirm;
  String? mobileNum;
  bool? isSmsSent;

  Data({
    this.token,
    this.confirm,
    this.mobileNum,
    this.isSmsSent,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    confirm: json["confirm"],
    mobileNum: json["mobile_num"],
    isSmsSent: json["is_sms_sent"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "confirm": confirm,
    "mobile_num": mobileNum,
    "is_sms_sent": isSmsSent,
  };
}
