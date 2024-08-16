class NotificationModel {
  late String id;
  late String title;
  late String body;
  late String type;
  late String? avatarUrl;
  late String senderName;
  late String createdAt;
  late String updatedAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.avatarUrl,
    required this.senderName,
    required this.createdAt,
    required this.updatedAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    avatarUrl = json['avatarUrl'];
    senderName = json['senderName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['type'] = type;
    data['avatarUrl'] = avatarUrl;
    data['senderName'] = senderName;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}


