import 'dart:convert';

class PagingModel {
  int pageSize;
  int pageNumber;

  PagingModel({
    required this.pageSize,
    required this.pageNumber,
  });

  factory PagingModel.fromJson(Map<String, dynamic> json) {
    return PagingModel(
      pageSize: json['page'],
      pageNumber: json['pages'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page-size'] = this.pageSize;
    data['page-number'] = this.pageNumber;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
