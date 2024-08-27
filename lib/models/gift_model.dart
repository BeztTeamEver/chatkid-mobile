import 'dart:convert';

class GiftModel {
  String? id;
  String? title;
  int? numberOfCoin;
  String? imageUrl;
  String? createdAt;
  String? status;

  GiftModel({
    this.id,
    this.title,
    this.numberOfCoin,
    this.imageUrl,
    this.createdAt,
    this.status,
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
    createdAt = DateTime.parse(json['createdAt']).toLocal().toIso8601String();
    status = json['status'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['numberOfCoin'] = numberOfCoin;
    data['imageUrl'] = imageUrl;
    data['createdAt'] = createdAt;
    data['status'] = status;
    return data;
  }
}
