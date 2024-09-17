
class OpeningComplainModel {
  int? code;
  Data? data;
  String? msg;

  OpeningComplainModel({
    this.code,
    this.data,
    this.msg,
  });

  factory OpeningComplainModel.fromJson(Map<String, dynamic> json) => OpeningComplainModel(
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
  List<Reply>? replies;
  Pagination? pagination;

  Data({
    this.replies,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    replies: json["replies"] == null ? [] : List<Reply>.from(json["replies"]!.map((x) => Reply.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Pagination {
  Pages? pages;
  int? count;
  String? current;

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

class Reply {
  ComplaintBasicInfo? complaintBasicInfo;

  Reply({
    this.complaintBasicInfo,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    complaintBasicInfo: json["complaint_basic_info"] == null ? null : ComplaintBasicInfo.fromJson(json["complaint_basic_info"]),
  );

  Map<String, dynamic> toJson() => {
    "complaint_basic_info": complaintBasicInfo?.toJson(),
  };
}

class ComplaintBasicInfo {
  String? id;
  String? complaintNumber;
  String? dateOfComplaint;
  String? complainantName;
  String? defendantName;
  bool? close;
  String? textOfComplaint;
  String? repliesCount;

  ComplaintBasicInfo({
    this.id,
    this.complaintNumber,
    this.dateOfComplaint,
    this.complainantName,
    this.defendantName,
    this.close,
    this.textOfComplaint,
    this.repliesCount,
  });

  factory ComplaintBasicInfo.fromJson(Map<String, dynamic> json) => ComplaintBasicInfo(
    id: json["id"],
    complaintNumber: json["complaint_number"],
    dateOfComplaint: json["date_of_complaint"],
    complainantName: json["complainant_name"],
    defendantName: json["defendant_name"],
    close: json["close"],
    textOfComplaint: json["text_of_complaint"],
    repliesCount: json["replies_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "complaint_number": complaintNumber,
    "date_of_complaint": dateOfComplaint,
    "complainant_name": complainantName,
    "defendant_name": defendantName,
    "close": close,
    "text_of_complaint": textOfComplaint,
    "replies_count": repliesCount,
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
