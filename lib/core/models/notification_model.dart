
class NotificationModel {
  int? code;
  Data? data;
  String? msg;

  NotificationModel({
    this.code,
    this.data,
    this.msg,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
  List<NotificationData>? notifications;
  Pagination? pagination;

  Data({
    this.notifications,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: json["notifications"] == null ? [] : List<NotificationData>.from(json["notifications"]!.map((x) => NotificationData.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class NotificationData {
  String? notifyId;
  DateTime? dateOfNotify;
  String? title;
  String? description;
  String? isclicked;
  String? seen;
  String? dateOfSeen;
  Variables? variables;

  NotificationData({
    this.notifyId,
    this.dateOfNotify,
    this.title,
    this.description,
    this.isclicked,
    this.seen,
    this.dateOfSeen,
    this.variables,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    notifyId: json["notify_id"],
    dateOfNotify: json["date_of_notify"] == null ? null : DateTime.parse(json["date_of_notify"]),
    title: json["title"],
    description: json["description"],
    isclicked: json["isclicked"],
    seen: json["seen"],
    dateOfSeen: json["date_of_seen"],
    variables: json["variables"] == null ? null : Variables.fromJson(json["variables"]),
  );

  Map<String, dynamic> toJson() => {
    "notify_id": notifyId,
    "date_of_notify": dateOfNotify?.toIso8601String(),
    "title": title,
    "description": description,
    "isclicked": isclicked,
    "seen": seen,
    "date_of_seen": dateOfSeen,
    "variables": variables?.toJson(),
  };
}

class Variables {
  String? complaintId;
  String? screen;
  int? replyId;

  Variables({
    this.complaintId,
    this.screen,
    this.replyId,
  });

  factory Variables.fromJson(Map<String, dynamic> json) => Variables(
    complaintId: json["complaint_id"],
    screen: json["screen"],
    replyId: json["reply_id"],
  );

  Map<String, dynamic> toJson() => {
    "complaint_id": complaintId,
    "screen": screen,
    "reply_id": replyId,
  };
}

class Pagination {
  Pages? pages;
  int? count;
  int? current;

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
