class BlogModel {
  String? id;
  String? title;
  String? content;
  String? imageUrl;
  String? voiceUrl;
  String? createdBy;
  String? updatedBy;  
  int? status;  
  String? createdAt;  
  String? updatedAt;
  String? theme;

  BlogModel({this.id, this.title, this.content, this.imageUrl, this.voiceUrl, this.createdBy, this.updatedBy, this.status, this.createdAt, this.updatedAt, this.theme});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    imageUrl = json['imageUrl'];
    voiceUrl = json['voiceUrl'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    theme = json['theme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['imageUrl'] = imageUrl;
    data['voiceUrl'] = voiceUrl;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['theme'] = theme;
    return data;
  }
}
