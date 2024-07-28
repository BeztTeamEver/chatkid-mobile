import 'dart:convert';

class PagingModel {
  int pageSize;
  int pageNumber;
  String? search;

  PagingModel({
    required this.pageSize,
    required this.pageNumber,
    this.search,
  });

  factory PagingModel.fromJson(Map<String, dynamic> json) {
    return PagingModel(
      pageSize: json['page'],
      pageNumber: json['pages'],
      search: json['search'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page-size'] = this.pageSize;
    data['page-number'] = this.pageNumber;
    data['search'] = this.search;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class PagingModelWithFilter<T> extends PagingModel {
  T? filter;

  PagingModelWithFilter({
    required int pageSize,
    required int pageNumber,
    String? search,
    this.filter,
  }) : super(pageSize: pageSize, pageNumber: pageNumber, search: search);

  factory PagingModelWithFilter.fromJson(Map<String, dynamic> json) {
    return PagingModelWithFilter(
      pageSize: json['page'],
      pageNumber: json['pages'],
      search: json['search'],
      filter: json['filter'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page-size'] = this.pageSize;
    data['page-number'] = this.pageNumber;
    data['search'] = this.search;
    data['filter'] = this.filter;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
