
class GetHourlyPackageModel {
  int? code;
  List<Package>? data;
  String? msg;

  GetHourlyPackageModel({
    this.code,
    this.data,
    this.msg,
  });

  factory GetHourlyPackageModel.fromJson(Map<String, dynamic> json) => GetHourlyPackageModel(
    code: json["code"],
    data: json["data"] == null ? [] : List<Package>.from(json["data"]!.map((x) => Package.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class Package {
  String? id;
  String? name;
  String? serviceTimeSelectsMethod;
  String? restrictServiceTimeStart;
  String? restrictServiceTimeEnd;
  String? maxServiceTimeDurationLimit;
  String? countOfWorkersSelectsMethod;
  String? restrictCountOfWorkers;
  String? maxCountOfWorkersLimit;
  String? serviceDaysSelectsMethod;
  String? maxServiceDaysLimit;
  List<AvailableCountry>? availableCountries;
  String? occId;
  String? costOfWorkerPerHour;
  String? taxRatio;
  List<AvailableServicePackage>? availableServicePackage;

  Package({
    this.id,
    this.name,
    this.serviceTimeSelectsMethod,
    this.restrictServiceTimeStart,
    this.restrictServiceTimeEnd,
    this.maxServiceTimeDurationLimit,
    this.countOfWorkersSelectsMethod,
    this.restrictCountOfWorkers,
    this.maxCountOfWorkersLimit,
    this.serviceDaysSelectsMethod,
    this.maxServiceDaysLimit,
    this.availableCountries,
    this.occId,
    this.costOfWorkerPerHour,
    this.taxRatio,
    this.availableServicePackage,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"],
    name: json["name"],
    serviceTimeSelectsMethod: json["service_time_selects_method"],
    restrictServiceTimeStart: json["restrict_service_time_start"],
    restrictServiceTimeEnd: json["restrict_service_time_end"],
    maxServiceTimeDurationLimit: json["max_service_time_duration_limit"],
    countOfWorkersSelectsMethod: json["count_of_workers_selects_method"],
    restrictCountOfWorkers: json["restrict_count_of_workers"],
    maxCountOfWorkersLimit: json["max_count_of_workers_limit"],
    serviceDaysSelectsMethod: json["service_days_selects_method"],
    maxServiceDaysLimit: json["max_service_days_limit"],
    availableCountries: json["available_countries"] == null ? [] : List<AvailableCountry>.from(json["available_countries"]!.map((x) => AvailableCountry.fromJson(x))),
    occId: json["occ_id"],
    costOfWorkerPerHour: json["cost_of_worker_per_hour"],
    taxRatio: json["tax_ratio"],
    availableServicePackage: json["available_service_package"] == null ? [] : List<AvailableServicePackage>.from(json["available_service_package"]!.map((x) => AvailableServicePackage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "service_time_selects_method": serviceTimeSelectsMethod,
    "restrict_service_time_start": restrictServiceTimeStart,
    "restrict_service_time_end": restrictServiceTimeEnd,
    "max_service_time_duration_limit": maxServiceTimeDurationLimit,
    "count_of_workers_selects_method": countOfWorkersSelectsMethod,
    "restrict_count_of_workers": restrictCountOfWorkers,
    "max_count_of_workers_limit": maxCountOfWorkersLimit,
    "service_days_selects_method": serviceDaysSelectsMethod,
    "max_service_days_limit": maxServiceDaysLimit,
    "available_countries": availableCountries == null ? [] : List<dynamic>.from(availableCountries!.map((x) => x.toJson())),
    "occ_id": occId,
    "cost_of_worker_per_hour": costOfWorkerPerHour,
    "tax_ratio": taxRatio,
    "available_service_package": availableServicePackage == null ? [] : List<dynamic>.from(availableServicePackage!.map((x) => x.toJson())),
  };
}

class AvailableCountry {
  String? id;
  String? name;
  InternationalCode? internationalCode;

  AvailableCountry({
    this.id,
    this.name,
    this.internationalCode,
  });

  factory AvailableCountry.fromJson(Map<String, dynamic> json) => AvailableCountry(
    id: json["id"],
    name: json["name"],
    internationalCode: internationalCodeValues.map[json["international_code"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "international_code": internationalCodeValues.reverse[internationalCode],
  };
}

enum InternationalCode {
  BD,
  IN,
  LK,
  PH
}

final internationalCodeValues = EnumValues({
  "bd": InternationalCode.BD,
  "in": InternationalCode.IN,
  "lk": InternationalCode.LK,
  "ph": InternationalCode.PH
});

enum Name {
  EMPTY,
  FLUFFY,
  NAME,
  PURPLE
}

final nameValues = EnumValues({
  "الهند": Name.EMPTY,
  "الفلبين": Name.FLUFFY,
  "سريلانكا": Name.NAME,
  "بنجلاديش": Name.PURPLE
});

class AvailableServicePackage {
  String? id;
  String? title;
  String? fromTime;
  String? toTime;

  AvailableServicePackage({
    this.id,
    this.title,
    this.fromTime,
    this.toTime,
  });

  factory AvailableServicePackage.fromJson(Map<String, dynamic> json) => AvailableServicePackage(
    id: json["id"],
    title: json["title"],
    fromTime: json["from_time"],
    toTime: json["to_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "from_time": fromTime,
    "to_time": toTime,
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
