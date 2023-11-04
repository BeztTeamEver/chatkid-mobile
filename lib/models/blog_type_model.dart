class BlogTypeModel {
  String? id;
  String? name;
  String? imageUrl;

  BlogTypeModel({this.id, this.name, this.imageUrl});

  BlogTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
