
class AddComplainModel {
  int? code;
  Data? data;
  String? msg;

  AddComplainModel({
    this.code,
    this.data,
    this.msg,
  });

  factory AddComplainModel.fromJson(Map<String, dynamic> json) => AddComplainModel(
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
  ComplaintBasicInfo? complaintBasicInfo;
  List<ComplaintReply>? complaintReplies;

  Data({
    this.complaintBasicInfo,
    this.complaintReplies,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    complaintBasicInfo: json["complaint_basic_info"] == null ? null : ComplaintBasicInfo.fromJson(json["complaint_basic_info"]),
    complaintReplies: json["complaint_replies"] == null ? [] : List<ComplaintReply>.from(json["complaint_replies"]!.map((x) => ComplaintReply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "complaint_basic_info": complaintBasicInfo?.toJson(),
    "complaint_replies": complaintReplies == null ? [] : List<dynamic>.from(complaintReplies!.map((x) => x.toJson())),
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

class ComplaintReply {
  String? content;
  String? mainContent;
  DateTime? dateOfReply;
  String? byComplainant;
  String? byDefendant;
  String? byWatcher;
  String? replyId;
  List<Attachment>? attachments;

  ComplaintReply({
    this.content,
    this.mainContent,
    this.dateOfReply,
    this.byComplainant,
    this.byDefendant,
    this.byWatcher,
    this.replyId,
    this.attachments,
  });

  factory ComplaintReply.fromJson(Map<String, dynamic> json) => ComplaintReply(
    content: json["content"],
    mainContent: json["main_content"],
    dateOfReply: json["date_of_reply"] == null ? null : DateTime.parse(json["date_of_reply"]),
    byComplainant: json["by_complainant"],
    byDefendant: json["by_defendant"],
    byWatcher: json["by_watcher"],
    replyId: json["reply_id"],
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "main_content": mainContent,
    "date_of_reply": "${dateOfReply!.year.toString().padLeft(4, '0')}-${dateOfReply!.month.toString().padLeft(2, '0')}-${dateOfReply!.day.toString().padLeft(2, '0')}",
    "by_complainant": byComplainant,
    "by_defendant": byDefendant,
    "by_watcher": byWatcher,
    "reply_id": replyId,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
  };
}

class Attachment {
  String? filename;
  String? fileUrlPath;
  String? serverUrlPath;
  String? serverPathAttachment;

  Attachment({
    this.filename,
    this.fileUrlPath,
    this.serverUrlPath,
    this.serverPathAttachment,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    filename: json["filename"],
    fileUrlPath: json["file_url_path"],
    serverUrlPath: json["server_url_path"],
    serverPathAttachment: json["server_path_attachment"],
  );

  Map<String, dynamic> toJson() => {
    "filename": filename,
    "file_url_path": fileUrlPath,
    "server_url_path": serverUrlPath,
    "server_path_attachment": serverPathAttachment,
  };
}
