class HistoryTrackingModel {
  String? id;
  String? userId;
  String? serviceName;
  DateTime? createdTime;
  String? content;
  String? answer;

  HistoryTrackingModel(
      {this.id,
      this.userId,
      this.serviceName,
      this.createdTime,
      this.content,
      this.answer});

  HistoryTrackingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    serviceName = json['serviceName'];
    createdTime = DateTime.tryParse(json['createdTime']);
    content = json['content'];
    answer = json['answer'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['serviceName'] = this.serviceName;
    data['createdTime'] = this.createdTime.toString();
    data['content'] = this.content;
    data['answer'] = this.answer;
    return data;
  }
}
