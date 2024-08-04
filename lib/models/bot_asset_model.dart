import 'dart:convert';

class BotAssetModel {
  late String id;
  String? name;
  String? imageUrl;
  String? previewImageUrl;
  int? position;
  int? price;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? status;

  BotAssetModel(
      {required this.id,
      this.name,
      this.imageUrl,
      this.previewImageUrl,
      this.position,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.status});

  BotAssetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    previewImageUrl = json['previewImageUrl'];
    position = json['position'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['previewImageUrl'] = previewImageUrl;
    data['position'] = position;
    data['price'] = price;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['type'] = type;
    data['status'] = status;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class BotAssetTypeModel {
  List<BotAssetModel>? background;
  List<BotAssetModel>? cloak;
  List<BotAssetModel>? emoji;
  List<BotAssetModel>? hat;
  List<BotAssetModel>? eyes;
  List<BotAssetModel>? ears;
  List<BotAssetModel>? necklace;

  BotAssetTypeModel(
      {this.background,
      this.cloak,
      this.ears,
      this.emoji,
      this.eyes,
      this.hat,
      this.necklace});

  BotAssetTypeModel.fromJson(Map<String, dynamic> json) {
    background = List.from(json['background']).map((e) {
      return BotAssetModel.fromJson(e);
    }).toList();
    cloak =
        List.from(json['cloak']).map((e) => BotAssetModel.fromJson(e)).toList();
    ears =
        List.from(json['ears']).map((e) => BotAssetModel.fromJson(e)).toList();
    emoji =
        List.from(json['emoji']).map((e) => BotAssetModel.fromJson(e)).toList();
    eyes =
        List.from(json['eyes']).map((e) => BotAssetModel.fromJson(e)).toList();
    hat = List.from(json['hat']).map((e) => BotAssetModel.fromJson(e)).toList();
    necklace = List.from(json['necklace'])
        .map((e) => BotAssetModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['background'] = background;
    data['cloak'] = cloak;
    data['ears'] = ears;
    data['emoji'] = emoji;
    data['eyes'] = eyes;
    data['hat'] = hat;
    data['necklace'] = necklace;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
