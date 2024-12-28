
class jobs {
  String? employerName;
  String? employerEmail;
  String? itemID;
  String? employerUID;
  String? thumbnailUrl;
  String? itemTitle;
  String? unit;
  DateTime? dueDate;
  DateTime? publishedDate;
  String? longDescription;

  jobs({
    this.employerName,
    this.employerEmail,
    this.employerUID,
    this.itemID,
    this.thumbnailUrl,
    this.itemTitle,
    this.unit,
    this.dueDate,
    this.publishedDate,
    this.longDescription,
  });
  jobs.fromJson(Map<String, dynamic> json)
  {
    employerName = json["employerName"];
    employerEmail = json["employerEmail"];
    itemID = json["itemID"];
    employerUID = json["employerUID"];
    thumbnailUrl = json["thumbnailUrl"];
    itemTitle = json["itemTitle"];
    unit = json["unit"];
    dueDate = json["DueDate"].toDate();
    publishedDate = json["publishedDate"].toDate();
    longDescription = json["longDescription"];
  }

}