
class ClosedComplainModel {
  int? code;
  Data? data;
  String? msg;

  ClosedComplainModel({
    this.code,
    this.data,
    this.msg,
  });

  factory ClosedComplainModel.fromJson(Map<String, dynamic> json) => ClosedComplainModel(
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
  List<ReplyClosedComplain>? replies;
  Pagination? pagination;

  Data({
    this.replies,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    replies: json["replies"] == null ? [] : List<ReplyClosedComplain>.from(json["replies"]!.map((x) => ReplyClosedComplain.fromJson(x))),
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

class ReplyClosedComplain {
  ComplaintBasicInfo? complaintBasicInfo;

  ReplyClosedComplain({
    this.complaintBasicInfo,
  });

  factory ReplyClosedComplain.fromJson(Map<String, dynamic> json) => ReplyClosedComplain(
    complaintBasicInfo: json["complaint_basic_info"] == null ? null : ComplaintBasicInfo.fromJson(json["complaint_basic_info"]),
  );

  Map<String, dynamic> toJson() => {
    "complaint_basic_info": complaintBasicInfo?.toJson(),
  };
}

class ComplaintBasicInfo {
  String? id;
  String? complaintNumber;
  DateTime? dateOfComplaint;
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
    dateOfComplaint: json["date_of_complaint"] == null ? null : DateTime.parse(json["date_of_complaint"]),
    complainantName: json["complainant_name"],
    defendantName: json["defendant_name"],
    close: json["close"],
    textOfComplaint: json["text_of_complaint"],
    repliesCount: json["replies_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "complaint_number": complaintNumber,
    "date_of_complaint": "${dateOfComplaint!.year.toString().padLeft(4, '0')}-${dateOfComplaint!.month.toString().padLeft(2, '0')}-${dateOfComplaint!.day.toString().padLeft(2, '0')}",
    "complainant_name": complainantName,
    "defendant_name": defendantName,
    "close": close,
    "text_of_complaint": textOfComplaint,
    "replies_count": repliesCount,
  };
}
