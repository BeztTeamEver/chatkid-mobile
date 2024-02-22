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

class PagingResponseModel<T extends IBaseModel> {
  List<T> items;
  int limit;
  int totalItems;
  int page;

  PagingResponseModel({
    required this.items,
    required this.limit,
    required this.totalItems,
    required this.page,
  });

  factory PagingResponseModel.fromJson(Map<String, dynamic> json) {
    return PagingResponseModel(
      items: json['items'],
      limit: json['limit'],
      totalItems: json['totalItems'],
      page: json['page'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['items'] = this.items;
    data['limit'] = this.limit;
    data['totalItems'] = this.totalItems;
    data['page'] = this.page;
    return data;
  }
}
