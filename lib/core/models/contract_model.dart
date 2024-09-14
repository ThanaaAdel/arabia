
class ContractModel {
  int? code;
  Data? data;
  String? msg;

  ContractModel({
    this.code,
    this.data,
    this.msg,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) => ContractModel(
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
  List<Item>? items;
  Pagination? pagination;

  Data({
    this.items,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Item {
  String? title;
  String? containsOn;
  String? statusClient;
  String? fileId;
  String? filenameStore;
  String? filename;
  DateTime? createdAt;
  String? groupBundle;
  StatusDisplay? statusDisplay;
  String? fileUrlPath;

  Item({
    this.title,
    this.containsOn,
    this.statusClient,
    this.fileId,
    this.filenameStore,
    this.filename,
    this.createdAt,
    this.groupBundle,
    this.statusDisplay,
    this.fileUrlPath,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    title: json["title"],
    containsOn: json["contains_on"],
    statusClient: json["status_client"],
    fileId: json["file_id"],
    filenameStore: json["filename_store"],
    filename: json["filename"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    groupBundle: json["group_bundle"],
    statusDisplay: json["status_display"] == null ? null : StatusDisplay.fromJson(json["status_display"]),
    fileUrlPath: json["file_url_path"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "contains_on": containsOn,
    "status_client": statusClient,
    "file_id": fileId,
    "filename_store": filenameStore,
    "filename": filename,
    "created_at": createdAt?.toIso8601String(),
    "group_bundle": groupBundle,
    "status_display": statusDisplay?.toJson(),
    "file_url_path": fileUrlPath,
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

class Pagination {
  Pages? pages;
  int? count;
  int? current;

  Pagination({
    this.pages,
    this.count,
    this.current,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    pages: json["pages"] == null ? null : Pages.fromJson(json["pages"]),
    count: json["count"],
    current: json["current"],
  );

  Map<String, dynamic> toJson() => {
    "pages": pages?.toJson(),
    "count": count,
    "current": current,
  };
}

class Pages {
  int? the1;

  Pages({
    this.the1,
  });

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
    the1: json["1"],
  );

  Map<String, dynamic> toJson() => {
    "1": the1,
  };
}
