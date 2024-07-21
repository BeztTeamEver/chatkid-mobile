class SubcriptionModel {
  late String id;
  late String name;
  late int price;
  late int actualPrice;
  late int diamond;

  SubcriptionModel({
    required this.id,
    required this.name,
    required this.price,
    required this.actualPrice,
    required this.diamond,
  });

  SubcriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    actualPrice = json['actualPrice'];
    diamond = json['diamond'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['actualPrice'] = actualPrice;
    data['diamond'] = diamond;
    return data;
  }
}
