import 'dart:ffi';

class SubcriptionModel {
  final String? id;
  final String? name;
  final double? price;
  final double? actualPrice;
  final int? energy;
  final int? status;

  const SubcriptionModel(
      {this.id,
      this.name,
      this.price,
      this.actualPrice,
      this.energy,
      this.status});

  factory SubcriptionModel.fromJson(Map<String, dynamic> json) {
    return SubcriptionModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as int).toDouble(),
      actualPrice: (json['actualPrice'] as int).toDouble(),
      energy: json['energy'],
      status: json['status'],
    );
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
