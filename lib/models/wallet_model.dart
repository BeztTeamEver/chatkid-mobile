import 'dart:convert';

class WalletModel {
  String? id;
  int? totalEnergy;
  String? updatedTime;

  WalletModel({this.id, this.totalEnergy, this.updatedTime});

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalEnergy = json['totalEnergy'];
    updatedTime = json['updatedTime'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalEnergy'] = this.totalEnergy;
    data['updatedTime'] = this.updatedTime;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
