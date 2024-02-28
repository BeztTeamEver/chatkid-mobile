class SubcriptionModel {
  late String id;
  late String name;
  late String price;
  late String actualPrice;
  late int energy;
  late int status;

  SubcriptionModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.actualPrice,
      required this.energy,
      required this.status});

  SubcriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    actualPrice = json['actualPrice'];
    energy = json['energy'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['actualPrice'] = actualPrice;
    data['energy'] = energy;
    data['status'] = status;
    return data;
  }
}
