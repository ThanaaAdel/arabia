


class GetMonthlyDataModel {
  int? code;
  List<MonthlyPackage>? data;
  String? msg;

  GetMonthlyDataModel({
    this.code,
    this.data,
    this.msg,
  });

  factory GetMonthlyDataModel.fromJson(Map<String, dynamic> json) => GetMonthlyDataModel(
    code: json["code"],
    data: json["data"] == null ? [] : List<MonthlyPackage>.from(json["data"]!.map((x) => MonthlyPackage.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class MonthlyPackage {
  String? id;
  String? name;
  String? occId;
  List<AvailableCountry>? availableCountries;
  String? costOneWorkerPerMonth;
  String? maxWorkersCount;
  String? costTransferServicePerOneWorker;
  bool? giveTransferServiceOption;
  String? taxRatio;
  String? countOfDaysInOneMonth;
  String? minRentalDurationPerMonth;

  MonthlyPackage({
    this.id,
    this.name,
    this.occId,
    this.availableCountries,
    this.costOneWorkerPerMonth,
    this.maxWorkersCount,
    this.costTransferServicePerOneWorker,
    this.giveTransferServiceOption,
    this.taxRatio,
    this.countOfDaysInOneMonth,
    this.minRentalDurationPerMonth,
  });

  factory MonthlyPackage.fromJson(Map<String, dynamic> json) => MonthlyPackage(
    id: json["id"],
    name: json["name"],
    occId: json["occ_id"],
    availableCountries: json["available_countries"] == null ? [] : List<AvailableCountry>.from(json["available_countries"]!.map((x) => AvailableCountry.fromJson(x))),
    costOneWorkerPerMonth: json["cost_one_worker_per_month"],
    maxWorkersCount: json["max_workers_count"],
    costTransferServicePerOneWorker: json["cost_transfer_service_per_one_worker"],
    giveTransferServiceOption: json["give_transfer_service_option"],
    taxRatio: json["tax_ratio"],
    countOfDaysInOneMonth: json["count_of_days_in_one_month"],
    minRentalDurationPerMonth: json["min_rental_duration_per_month"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "occ_id": occId,
    "available_countries": availableCountries == null ? [] : List<dynamic>.from(availableCountries!.map((x) => x.toJson())),
    "cost_one_worker_per_month": costOneWorkerPerMonth,
    "max_workers_count": maxWorkersCount,
    "cost_transfer_service_per_one_worker": costTransferServicePerOneWorker,
    "give_transfer_service_option": giveTransferServiceOption,
    "tax_ratio": taxRatio,
    "count_of_days_in_one_month": countOfDaysInOneMonth,
    "min_rental_duration_per_month": minRentalDurationPerMonth,
  };
}

class AvailableCountry {
  String? id;

  String? name;
  String? internationalCode;

  AvailableCountry({
    this.id,
    this.name,
    this.internationalCode,
  });

  factory AvailableCountry.fromJson(Map<String, dynamic> json) => AvailableCountry(
    id: json["id"],
    name:json["name"],
    internationalCode: json["international_code"]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "international_code": internationalCode,
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
