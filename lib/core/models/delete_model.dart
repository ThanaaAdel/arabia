
class DeleteAccountModel {
  final Data? data;
  final String? message;
  final int? code;

  DeleteAccountModel({
    this.data,
    this.message,
    this.code,
  });

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) => DeleteAccountModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["msg"],  // Adjust to match "msg" field from your JSON
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": message,  // Adjust to match "msg" field from your JSON
    "code": code,
  };
}

class Data {
  final String? deleteAccountUrl;

  Data({
    this.deleteAccountUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    deleteAccountUrl: json["delete_account_url"],
  );

  Map<String, dynamic> toJson() => {
    "delete_account_url": deleteAccountUrl,
  };
}
