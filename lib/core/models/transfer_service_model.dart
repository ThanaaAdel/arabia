
class TransferServiceModel {
  int? code;
  Data? data;
  String? msg;

  TransferServiceModel({
    this.code,
    this.data,
    this.msg,
  });

  factory TransferServiceModel.fromJson(Map<String, dynamic> json) => TransferServiceModel(
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
  String? id;
  String? clientId;
  String? clientName;
  String? clientMobile;
  String? clientIdentityNo;
  String? currentWorkerCountryId;
  String? currentWorkerOccId;
  CurrentWorkerReligion? currentWorkerReligion;
  CurrentWorkerReligion? transferType;
  String? costWithoutTax;
  String? costTax;
  String? costTaxRatio;
  String? costIncludeTax;
  String? statusClient;
  DateTime? createdAt;
  CurrentWorkerReligion? statusDisplay;
  CurrentWorkerCountry? currentWorkerCountry;
  CurrentWorkerOccupation? currentWorkerOccupation;

  Item({
    this.id,
    this.clientId,
    this.clientName,
    this.clientMobile,
    this.clientIdentityNo,
    this.currentWorkerCountryId,
    this.currentWorkerOccId,
    this.currentWorkerReligion,
    this.transferType,
    this.costWithoutTax,
    this.costTax,
    this.costTaxRatio,
    this.costIncludeTax,
    this.statusClient,
    this.createdAt,
    this.statusDisplay,
    this.currentWorkerCountry,
    this.currentWorkerOccupation,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    clientId: json["client_id"],
    clientName: json["client_name"],
    clientMobile: json["client_mobile"],
    clientIdentityNo: json["client_identity_no"],
    currentWorkerCountryId: json["current_worker_country_id"],
    currentWorkerOccId: json["current_worker_occ_id"],
    currentWorkerReligion: json["current_worker_religion"] == null ? null : CurrentWorkerReligion.fromJson(json["current_worker_religion"]),
    transferType: json["transfer_type"] == null ? null : CurrentWorkerReligion.fromJson(json["transfer_type"]),
    costWithoutTax: json["cost_without_tax"],
    costTax: json["cost_tax"],
    costTaxRatio: json["cost_tax_ratio"],
    costIncludeTax: json["cost_include_tax"],
    statusClient: json["status_client"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    statusDisplay: json["status_display"] == null ? null : CurrentWorkerReligion.fromJson(json["status_display"]),
    currentWorkerCountry: json["current_worker_country"] == null ? null : CurrentWorkerCountry.fromJson(json["current_worker_country"]),
    currentWorkerOccupation: json["current_worker_occupation"] == null ? null : CurrentWorkerOccupation.fromJson(json["current_worker_occupation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "client_name": clientName,
    "client_mobile": clientMobile,
    "client_identity_no": clientIdentityNo,
    "current_worker_country_id": currentWorkerCountryId,
    "current_worker_occ_id": currentWorkerOccId,
    "current_worker_religion": currentWorkerReligion?.toJson(),
    "transfer_type": transferType?.toJson(),
    "cost_without_tax": costWithoutTax,
    "cost_tax": costTax,
    "cost_tax_ratio": costTaxRatio,
    "cost_include_tax": costIncludeTax,
    "status_client": statusClient,
    "created_at": createdAt?.toIso8601String(),
    "status_display": statusDisplay?.toJson(),
    "current_worker_country": currentWorkerCountry?.toJson(),
    "current_worker_occupation": currentWorkerOccupation?.toJson(),
  };
}

class CurrentWorkerCountry {
  String? id;
  String? name;
  String? internationalCode;

  CurrentWorkerCountry({
    this.id,
    this.name,
    this.internationalCode,
  });

  factory CurrentWorkerCountry.fromJson(Map<String, dynamic> json) => CurrentWorkerCountry(
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

class CurrentWorkerOccupation {
  String? id;
  String? name;

  CurrentWorkerOccupation({
    this.id,
    this.name,
  });

  factory CurrentWorkerOccupation.fromJson(Map<String, dynamic> json) => CurrentWorkerOccupation(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class CurrentWorkerReligion {
  String? id;
  String? title;

  CurrentWorkerReligion({
    this.id,
    this.title,
  });

  factory CurrentWorkerReligion.fromJson(Map<String, dynamic> json) => CurrentWorkerReligion(
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
