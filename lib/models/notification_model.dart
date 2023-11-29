class NotificationModel {
  String? id;
  String? title;
  String? content;
  String? receiver;
  String? creatorEmail;
  DateTime? createAt;
  DateTime? updateAt;
  DateTime? scheduleTime;
  int? status;

  NotificationModel(
      {this.id,
      this.title,
      this.content,
      this.receiver,
      this.creatorEmail,
      this.createAt,
      this.updateAt,
      this.scheduleTime,
      this.status});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    receiver = json['receiver'];
    creatorEmail = json['creatorEmail'];
    createAt = DateTime.tryParse(json['createAt']);
    updateAt = DateTime.tryParse(json['updateAt']);
    scheduleTime = DateTime.tryParse(json['scheduleTime']);
    status = json['status'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['receiver'] = this.receiver;
    data['creatorEmail'] = this.creatorEmail;
    data['createAt'] = this.createAt.toString();
    data['updateAt'] = this.updateAt.toString();
    data['scheduleTime'] = this.scheduleTime.toString();
    data['status'] = this.status;
    return data;
  }
}
