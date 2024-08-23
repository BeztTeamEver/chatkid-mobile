import 'dart:convert';

class GiftModel {
  String? id;
  String? title;
  int? numberOfCoin;
  String? imageUrl;
  String? createdAt;

  GiftModel({
    this.id,
    this.title,
    this.numberOfCoin,
    this.imageUrl,
    this.createdAt,
  });

  String toJson() {
    return jsonEncode({
      "title": title,
      "numberOfCoin": numberOfCoin,
      "imageUrl": imageUrl,
    });
  }

  GiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    numberOfCoin = json['numberOfCoin'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['numberOfCoin'] = this.numberOfCoin;
    data['imageUrl'] = this.imageUrl;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
