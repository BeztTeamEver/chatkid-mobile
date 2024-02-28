class BlogModel {
  String? id;
  String? title;
  String? content;
  String? imageUrl;
  String? voiceUrl;
  String? createdBy;
  String? updatedBy;  
  int? status;  
  String? typeBlogId;  
  String? createdAt;  
  String? updatedAt;  
  int? view;  
  String? theme;

  BlogModel({this.id, this.title, this.content, this.imageUrl, this.voiceUrl, this.createdBy, this.updatedBy, this.status, this.typeBlogId, this.createdAt, this.updatedAt, this.view, this.theme});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    imageUrl = json['imageUrl'];
    voiceUrl = json['voiceUrl'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    status = json['status'];
    typeBlogId = json['typeBlogId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    view = json['view'];
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
    data['typeBlogId'] = typeBlogId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['view'] = view;
    data['theme'] = theme;
    return data;
  }
}
