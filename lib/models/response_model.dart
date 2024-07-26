import 'package:chatkid_mobile/models/base_model.dart';
import 'package:chatkid_mobile/utils/utils.dart';

class ResponseModel<TData> {
  final String? statusCode;
  final TData? data;
  final List<dynamic>? errors;

  ResponseModel({this.statusCode, this.data, this.errors});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      statusCode: json['statusCode'],
      data: json['data'],
      errors: json['errors'],
    );
  }
}

class PagingResponseModel<T> {
  List<T> items;
  // int? limit;
  int totalItem;
  int pageNumber;
  int pageSize;

  PagingResponseModel({
    required this.items,
    // this.limit,
    required this.totalItem,
    required this.pageSize,
    required this.pageNumber,
  });

  factory PagingResponseModel.fromJson(Map<String, dynamic> json) {
    return PagingResponseModel(
      items: json['items'],
      // limit: json['limit'],
      totalItem: json['totalItem'],
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['items'] = this.items;
    // data['limit'] = this.limit;
    data['totalItem'] = this.totalItem;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    return data;
  }
}
