import 'dart:convert';

class KidServiceModel {
  String? id;
  String? serviceType;
  int? status;

  KidServiceModel({this.id, this.serviceType, this.status});

  KidServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceType = json['serviceType'];
    status = json['status'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['serviceType'] = serviceType;
    data['status'] = status;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
