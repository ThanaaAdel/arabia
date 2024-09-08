class Package {
  final String id;
  final String name;
  final String serviceTimeSelectsMethod;
  final String restrictServiceTimeStart;
  final String restrictServiceTimeEnd;
  final String maxServiceTimeDurationLimit;
  final String countOfWorkersSelectsMethod;
  final String restrictCountOfWorkers;
  final String maxCountOfWorkersLimit;
  final String serviceDaysSelectsMethod;
  final String maxServiceDaysLimit;
  final List<Country> availableCountries;
  final String occId;
  final String costOfWorkerPerHour;
  final String taxRatio;
  final List<ServicePackage> availableServicePackage;

  Package({
    required this.id,
    required this.name,
    required this.serviceTimeSelectsMethod,
    required this.restrictServiceTimeStart,
    required this.restrictServiceTimeEnd,
    required this.maxServiceTimeDurationLimit,
    required this.countOfWorkersSelectsMethod,
    required this.restrictCountOfWorkers,
    required this.maxCountOfWorkersLimit,
    required this.serviceDaysSelectsMethod,
    required this.maxServiceDaysLimit,
    required this.availableCountries,
    required this.occId,
    required this.costOfWorkerPerHour,
    required this.taxRatio,
    required this.availableServicePackage,
  });

  // Method to create a Package object from a JSON map
  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      name: json['name'],
      serviceTimeSelectsMethod: json['service_time_selects_method'],
      restrictServiceTimeStart: json['restrict_service_time_start'],
      restrictServiceTimeEnd: json['restrict_service_time_end'],
      maxServiceTimeDurationLimit: json['max_service_time_duration_limit'],
      countOfWorkersSelectsMethod: json['count_of_workers_selects_method'],
      restrictCountOfWorkers: json['restrict_count_of_workers'],
      maxCountOfWorkersLimit: json['max_count_of_workers_limit'],
      serviceDaysSelectsMethod: json['service_days_selects_method'],
      maxServiceDaysLimit: json['max_service_days_limit'],
      availableCountries: (json['available_countries'] as List)
          .map((country) => Country.fromJson(country))
          .toList(),
      occId: json['occ_id'],
      costOfWorkerPerHour: json['cost_of_worker_per_hour'],
      taxRatio: json['tax_ratio'],
      availableServicePackage: (json['available_service_package'] as List)
          .map((package) => ServicePackage.fromJson(package))
          .toList(),
    );
  }
}

class Country {
  final String id;
  final String name;
  final String internationalCode;

  Country({
    required this.id,
    required this.name,
    required this.internationalCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      internationalCode: json['international_code'],
    );
  }
}

class ServicePackage {
  final String id;
  final String title;
  final String fromTime;
  final String toTime;

  ServicePackage({
    required this.id,
    required this.title,
    required this.fromTime,
    required this.toTime,
  });

  factory ServicePackage.fromJson(Map<String, dynamic> json) {
    return ServicePackage(
      id: json['id'],
      title: json['title'],
      fromTime: json['from_time'],
      toTime: json['to_time'],
    );
  }
}
