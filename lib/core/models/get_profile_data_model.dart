
class GetProfileDataModel {
  int? code;
  Data? data;
  dynamic msg;

  GetProfileDataModel({
    this.code,
    this.data,
    this.msg,
  });

  factory GetProfileDataModel.fromJson(Map<String, dynamic> json) => GetProfileDataModel(
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
  String? mobile;
  String? identityNo;
  String? firstname;
  String? lastname;
  String? fullNameEn;
  String? birthday;
  String? national;
  String? houseAvenue;
  String? houseDistrict;
  String? houseCity;
  String? familyNo;
  String? region;
  String? houseAvenueEn;
  String? houseDistrictEn;
  String? regionEn;
  String? houseCityEn;
  String? email;
  String? isCompany;

  Data({
    this.id,
    this.mobile,
    this.identityNo,
    this.firstname,
    this.lastname,
    this.fullNameEn,
    this.birthday,
    this.national,
    this.houseAvenue,
    this.houseDistrict,
    this.houseCity,
    this.familyNo,
    this.region,
    this.houseAvenueEn,
    this.houseDistrictEn,
    this.regionEn,
    this.houseCityEn,
    this.email,
    this.isCompany,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    mobile: json["mobile"],
    identityNo: json["identity_no"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    fullNameEn: json["full_name_en"],
    birthday: json["birthday"],
    national: json["national"],
    houseAvenue: json["house_avenue"],
    houseDistrict: json["house_district"],
    houseCity: json["house_city"],
    familyNo: json["family_no"],
    region: json["region"],
    houseAvenueEn: json["house_avenue_en"],
    houseDistrictEn: json["house_district_en"],
    regionEn: json["region_en"],
    houseCityEn: json["house_city_en"],
    email: json["email"],
    isCompany: json["is_company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobile": mobile,
    "identity_no": identityNo,
    "firstname": firstname,
    "lastname": lastname,
    "full_name_en": fullNameEn,
    "birthday": birthday,
    "national": national,
    "house_avenue": houseAvenue,
    "house_district": houseDistrict,
    "house_city": houseCity,
    "family_no": familyNo,
    "region": region,
    "house_avenue_en": houseAvenueEn,
    "house_district_en": houseDistrictEn,
    "region_en": regionEn,
    "house_city_en": houseCityEn,
    "email": email,
    "is_company": isCompany,
  };
}
