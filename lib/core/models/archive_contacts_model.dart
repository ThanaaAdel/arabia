
class ContractArchiveModel {
  int? code;
  Data? data;
  String? msg;

  ContractArchiveModel({
    this.code,
    this.data,
    this.msg,
  });

  factory ContractArchiveModel.fromJson(Map<String, dynamic> json) => ContractArchiveModel(
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
  String? attachId;
  String? branchId;
  String? title;
  String? containsOn;
  String? statusClient;
  String? fileId;
  String? filenameStore;
  String? filename;
  DateTime? createdAt;
  StatusDisplay? statusDisplay;

  Data({
    this.attachId,
    this.branchId,
    this.title,
    this.containsOn,
    this.statusClient,
    this.fileId,
    this.filenameStore,
    this.filename,
    this.createdAt,
    this.statusDisplay,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attachId: json["attach_id"],
    branchId: json["branch_id"],
    title: json["title"],
    containsOn: json["contains_on"],
    statusClient: json["status_client"],
    fileId: json["file_id"],
    filenameStore: json["filename_store"],
    filename: json["filename"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    statusDisplay: json["status_display"] == null ? null : StatusDisplay.fromJson(json["status_display"]),
  );

  Map<String, dynamic> toJson() => {
    "attach_id": attachId,
    "branch_id": branchId,
    "title": title,
    "contains_on": containsOn,
    "status_client": statusClient,
    "file_id": fileId,
    "filename_store": filenameStore,
    "filename": filename,
    "created_at": createdAt?.toIso8601String(),
    "status_display": statusDisplay?.toJson(),
  };
}

class StatusDisplay {
  String? id;
  String? title;

  StatusDisplay({
    this.id,
    this.title,
  });

  factory StatusDisplay.fromJson(Map<String, dynamic> json) => StatusDisplay(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
