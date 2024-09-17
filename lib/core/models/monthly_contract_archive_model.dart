
class MonthlyContractArchiveModel {
  int? code;
  Data? data;
  String? msg;

  MonthlyContractArchiveModel({
    this.code,
    this.data,
    this.msg,
  });

  factory MonthlyContractArchiveModel.fromJson(Map<String, dynamic> json) => MonthlyContractArchiveModel(
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
  String? monthlyRentalMobilePackageId;
  DateTime? serviceDateFrom;
  DateTime? serviceDateTo;
  String? serviceDurationPerCalculationMonths;
  String? serviceDurationPerSeconds;
  bool? isWantTransferService;
  String? countOfWorkers;
  String? countryId;
  String? occId;
  String? costWithoutTax;
  String? costTax;
  String? costTaxRatio;
  String? costIncludeTax;
  String? statusClient;
  DateTime? createdAt;
  MonthlyRentalMobilePackage? occupation;
  Country? country;
  StatusDisplay? statusDisplay;
  MonthlyRentalMobilePackage? monthlyRentalMobilePackage;

  Data({
    this.id,
    this.clientId,
    this.clientName,
    this.clientMobile,
    this.clientIdentityNo,
    this.monthlyRentalMobilePackageId,
    this.serviceDateFrom,
    this.serviceDateTo,
    this.serviceDurationPerCalculationMonths,
    this.serviceDurationPerSeconds,
    this.isWantTransferService,
    this.countOfWorkers,
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
    this.monthlyRentalMobilePackage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    clientId: json["client_id"],
    clientName: json["client_name"],
    clientMobile: json["client_mobile"],
    clientIdentityNo: json["client_identity_no"],
    monthlyRentalMobilePackageId: json["monthly_rental_mobile_package_id"],
    serviceDateFrom: json["service_date_from"] == null ? null : DateTime.parse(json["service_date_from"]),
    serviceDateTo: json["service_date_to"] == null ? null : DateTime.parse(json["service_date_to"]),
    serviceDurationPerCalculationMonths: json["service_duration_per_calculation_months"],
    serviceDurationPerSeconds: json["service_duration_per_seconds"],
    isWantTransferService: json["is_want_transfer_service"],
    countOfWorkers: json["count_of_workers"],
    countryId: json["country_id"],
    occId: json["occ_id"],
    costWithoutTax: json["cost_without_tax"],
    costTax: json["cost_tax"],
    costTaxRatio: json["cost_tax_ratio"],
    costIncludeTax: json["cost_include_tax"],
    statusClient: json["status_client"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    occupation: json["occupation"] == null ? null : MonthlyRentalMobilePackage.fromJson(json["occupation"]),
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    statusDisplay: json["status_display"] == null ? null : StatusDisplay.fromJson(json["status_display"]),
    monthlyRentalMobilePackage: json["monthly_rental_mobile_package"] == null ? null : MonthlyRentalMobilePackage.fromJson(json["monthly_rental_mobile_package"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "client_name": clientName,
    "client_mobile": clientMobile,
    "client_identity_no": clientIdentityNo,
    "monthly_rental_mobile_package_id": monthlyRentalMobilePackageId,
    "service_date_from": "${serviceDateFrom!.year.toString().padLeft(4, '0')}-${serviceDateFrom!.month.toString().padLeft(2, '0')}-${serviceDateFrom!.day.toString().padLeft(2, '0')}",
    "service_date_to": "${serviceDateTo!.year.toString().padLeft(4, '0')}-${serviceDateTo!.month.toString().padLeft(2, '0')}-${serviceDateTo!.day.toString().padLeft(2, '0')}",
    "service_duration_per_calculation_months": serviceDurationPerCalculationMonths,
    "service_duration_per_seconds": serviceDurationPerSeconds,
    "is_want_transfer_service": isWantTransferService,
    "count_of_workers": countOfWorkers,
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
    "monthly_rental_mobile_package": monthlyRentalMobilePackage?.toJson(),
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

class MonthlyRentalMobilePackage {
  String? id;
  String? name;

  MonthlyRentalMobilePackage({
    this.id,
    this.name,
  });

  factory MonthlyRentalMobilePackage.fromJson(Map<String, dynamic> json) => MonthlyRentalMobilePackage(
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
