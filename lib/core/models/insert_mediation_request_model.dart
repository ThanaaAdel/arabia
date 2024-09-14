
class InsertMediationRequestModel {
  int? code;
  Data? data;
  String? msg;

  InsertMediationRequestModel({
    this.code,
    this.data,
    this.msg,
  });

  factory InsertMediationRequestModel.fromJson(Map<String, dynamic> json) => InsertMediationRequestModel(
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
  String? countryId;
  String? occId;
  String? experience;
  String? religion;
  String? visaNo;
  String? costWithoutTax;
  String? costTax;
  String? costTaxRatio;
  String? costIncludeTax;
  String? statusClient;
  Occupation? occupation;
  Country? country;

  Data({
    this.id,
    this.clientId,
    this.clientName,
    this.clientMobile,
    this.clientIdentityNo,
    this.countryId,
    this.occId,
    this.experience,
    this.religion,
    this.visaNo,
    this.costWithoutTax,
    this.costTax,
    this.costTaxRatio,
    this.costIncludeTax,
    this.statusClient,
    this.occupation,
    this.country,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    clientId: json["client_id"],
    clientName: json["client_name"],
    clientMobile: json["client_mobile"],
    clientIdentityNo: json["client_identity_no"],
    countryId: json["country_id"],
    occId: json["occ_id"],
    experience: json["experience"],
    religion: json["religion"],
    visaNo: json["visa_no"],
    costWithoutTax: json["cost_without_tax"],
    costTax: json["cost_tax"],
    costTaxRatio: json["cost_tax_ratio"],
    costIncludeTax: json["cost_include_tax"],
    statusClient: json["status_client"],
    occupation: json["occupation"] == null ? null : Occupation.fromJson(json["occupation"]),
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "client_name": clientName,
    "client_mobile": clientMobile,
    "client_identity_no": clientIdentityNo,
    "country_id": countryId,
    "occ_id": occId,
    "experience": experience,
    "religion": religion,
    "visa_no": visaNo,
    "cost_without_tax": costWithoutTax,
    "cost_tax": costTax,
    "cost_tax_ratio": costTaxRatio,
    "cost_include_tax": costIncludeTax,
    "status_client": statusClient,
    "occupation": occupation?.toJson(),
    "country": country,
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
class Occupation {
  String? id;
  String? name;

  Occupation({
    this.id,
    this.name,
  });

  factory Occupation.fromJson(Map<String, dynamic> json) => Occupation(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
