class PackageModel {
  late String id;
  late String name;
  late int price;
  late int actualPrice;
  late int diamond;
  late String thumbnailUrl;

  PackageModel({
    required this.id,
    required this.name,
    required this.price,
    required this.actualPrice,
    required this.diamond,
    required this.thumbnailUrl,
  });

  PackageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    actualPrice = json['actualPrice'];
    diamond = json['diamond'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['actualPrice'] = actualPrice;
    data['diamond'] = diamond;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }
}
