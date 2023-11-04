class BlogModel {
  String? id;
  String? title;
  String? content;
  String? imageUrl;
  String? voiceUrl;

  BlogModel({this.id, this.title, this.content, this.imageUrl, this.voiceUrl});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    imageUrl = json['imageUrl'];
    voiceUrl = json['voiceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['imageUrl'] = imageUrl;
    data['voiceUrl'] = voiceUrl;
    return data;
  }
}
