

class InsertHourlyDataModel {
  int? code;
  Data? data;
  String? msg;

  InsertHourlyDataModel({
    this.code,
    this.data,
    this.msg,
  });

  factory InsertHourlyDataModel.fromJson(Map<String, dynamic> json) => InsertHourlyDataModel(
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
  String? createdAt;
  HourlyRentalMobilePackage? occupation;
  Country? country;
  StatusDisplay? statusDisplay;
  VisitPackage? visitPackage;
  HourlyRentalMobilePackage? hourlyRentalMobilePackage;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        : List<DateTime>.from(json["days_to_serve"]!.map((x) => DateTime.tryParse(x) ?? DateTime.now())), // استخدام tryParse للتأكد من أن التحليل آمن
    countryId: json["country_id"],
    occId: json["occ_id"],
    costWithoutTax: json["cost_without_tax"],
    costTax: json["cost_tax"],
    costTaxRatio: json["cost_tax_ratio"],
    costIncludeTax: json["cost_include_tax"],
    statusClient: json["status_client"],
    createdAt: json["created_at"],
    occupation: json["occupation"] == null ? null : HourlyRentalMobilePackage.fromJson(json["occupation"]),
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    statusDisplay: json["status_display"] == null ? null : StatusDisplay.fromJson(json["status_display"]),
    visitPackage: json["visit_package"] == null ? null : VisitPackage.fromJson(json["visit_package"]),
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
    "days_to_serve": daysToServe == null
        ? []
        : List<dynamic>.from(daysToServe!.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")), // التأكد من تنسيق التاريخ بشكل صحيح
    "country_id": countryId,
    "occ_id": occId,
    "cost_without_tax": costWithoutTax,
    "cost_tax": costTax,
    "cost_tax_ratio": costTaxRatio,
    "cost_include_tax": costIncludeTax,
    "status_client": statusClient,
    "created_at": createdAt,
    "occupation": occupation?.toJson(),
    "country": country?.toJson(),
    "status_display": statusDisplay?.toJson(),
    "visit_package": visitPackage?.toJson(),
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

class VisitPackage {
  String? id;
  String? title;
  String? fromTime;
  String? toTime;
  String? createAt;

  VisitPackage({
    this.id,
    this.title,
    this.fromTime,
    this.toTime,
    this.createAt,
  });

  factory VisitPackage.fromJson(Map<String, dynamic> json) => VisitPackage(
    id: json["id"],
    title: json["title"],
    fromTime: json["from_time"],
    toTime: json["to_time"],
    createAt: json["create_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "from_time": fromTime,
    "to_time": toTime,
    "create_at": createAt,
  };
}
