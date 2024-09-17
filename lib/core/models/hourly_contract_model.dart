// To parse this JSON data, do
//
//     final hourlyContractModel = hourlyContractModelFromJson(jsonString);

import 'dart:convert';

HourlyContractModel hourlyContractModelFromJson(String str) => HourlyContractModel.fromJson(json.decode(str));

String hourlyContractModelToJson(HourlyContractModel data) => json.encode(data.toJson());

class HourlyContractModel {
  int? code;
  Data? data;
  String? msg;

  HourlyContractModel({
    this.code,
    this.data,
    this.msg,
  });

  factory HourlyContractModel.fromJson(Map<String, dynamic> json) => HourlyContractModel(
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
  String? hourlyRentalMobilePackageId;
  String? visitPackageId;
  String? serviceTimeFrom;
  String? serviceTimeTo;
  String? serviceDurationPerSeconds;
  String? countOfWorkers;
  List<DateTime>? daysToServe;
  String? countryId;
  String? occId;
  String? costWithoutTax;
  String? costTax;
  String? costTaxRatio;
  String? costIncludeTax;
  String? statusClient;
  DateTime? createdAt; // Use DateTime type for createdAt
  HourlyRentalMobilePackage? occupation;
  Country? country;
  StatusDisplay? statusDisplay;
  dynamic visitPackage;
  HourlyRentalMobilePackage? hourlyRentalMobilePackage;

  Item({
    this.id,
    this.clientId,
    this.clientName,
    this.clientMobile,
    this.clientIdentityNo,
    this.hourlyRentalMobilePackageId,
    this.visitPackageId,
    this.serviceTimeFrom,
    this.serviceTimeTo,
    this.serviceDurationPerSeconds,
    this.countOfWorkers,
    this.daysToServe,
    this.countryId,
    this.occId,
    this.costWithoutTax,
    this.costTax,
    this.costTaxRatio,
    this.costIncludeTax,
    this.statusClient,
    this.createdAt,
    this.occupation,
    this.country,
    this.statusDisplay,
    this.visitPackage,
    this.hourlyRentalMobilePackage,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    clientId: json["client_id"],
    clientName: json["client_name"],
    clientMobile: json["client_mobile"],
    clientIdentityNo: json["client_identity_no"],
    hourlyRentalMobilePackageId: json["hourly_rental_mobile_package_id"],
    visitPackageId: json["visit_package_id"],
    serviceTimeFrom: json["service_time_from"],
    serviceTimeTo: json["service_time_to"],
    serviceDurationPerSeconds: json["service_duration_per_seconds"],
    countOfWorkers: json["count_of_workers"],
    daysToServe: json["days_to_serve"] == null
        ? []
        : List<DateTime>.from(json["days_to_serve"]!.map((x) => DateTime.tryParse(x) ?? DateTime(1970))), // Use tryParse with a fallback
    countryId: json["country_id"],
    occId: json["occ_id"],
    costWithoutTax: json["cost_without_tax"],
    costTax: json["cost_tax"],
    costTaxRatio: json["cost_tax_ratio"],
    costIncludeTax: json["cost_include_tax"],
    statusClient: json["status_client"],
    createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null, // Use tryParse to avoid errors
    occupation: json["occupation"] == null ? null : HourlyRentalMobilePackage.fromJson(json["occupation"]),
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    statusDisplay: json["status_display"] == null ? null : StatusDisplay.fromJson(json["status_display"]),
    visitPackage: json["visit_package"],
    hourlyRentalMobilePackage: json["hourly_rental_mobile_package"] == null ? null : HourlyRentalMobilePackage.fromJson(json["hourly_rental_mobile_package"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "client_name": clientName,
    "client_mobile": clientMobile,
    "client_identity_no": clientIdentityNo,
    "hourly_rental_mobile_package_id": hourlyRentalMobilePackageId,
    "visit_package_id": visitPackageId,
    "service_time_from": serviceTimeFrom,
    "service_time_to": serviceTimeTo,
    "service_duration_per_seconds": serviceDurationPerSeconds,
    "count_of_workers": countOfWorkers,
    "days_to_serve": daysToServe == null ? [] : List<dynamic>.from(daysToServe!.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
    "country_id": countryId,
    "occ_id": occId,
    "cost_without_tax": costWithoutTax,
    "cost_tax": costTax,
    "cost_tax_ratio": costTaxRatio,
    "cost_include_tax": costIncludeTax,
    "status_client": statusClient,
    "created_at": createdAt?.toIso8601String(),
    "occupation": occupation?.toJson(),
    "country": country?.toJson(),
    "status_display": statusDisplay?.toJson(),
    "visit_package": visitPackage,
    "hourly_rental_mobile_package": hourlyRentalMobilePackage?.toJson(),
  };
}


class Country {
  String? id;
  String? name;
  String? internationalCode;

  Country({
    this.id,
    this.name,
    this.internationalCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
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

class HourlyRentalMobilePackage {
  String? id;
  String? name;

  HourlyRentalMobilePackage({
    this.id,
    this.name,
  });

  factory HourlyRentalMobilePackage.fromJson(Map<String, dynamic> json) => HourlyRentalMobilePackage(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
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
  Map<String, int>? pages;
  int? count;
  int? current;

  Pagination({
    this.pages,
    this.count,
    this.current,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    pages: Map.from(json["pages"]!).map((k, v) => MapEntry<String, int>(k, v)),
    count: json["count"],
    current: json["current"],
  );

  Map<String, dynamic> toJson() => {
    "pages": Map.from(pages!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "count": count,
    "current": current,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
