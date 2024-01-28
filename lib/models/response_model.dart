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
  T data;
  int limit;
  int totalItems;
  int page;

  PagingResponseModel({
    required this.data,
    required this.limit,
    required this.totalItems,
    required this.page,
  });

  factory PagingResponseModel.fromJson(Map<String, dynamic> json) {
    return PagingResponseModel(
      data: json['data'],
      limit: json['limit'],
      totalItems: json['totalItems'],
      page: json['page'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['limit'] = this.limit;
    data['totalItems'] = this.totalItems;
    data['page'] = this.page;
    return data;
  }
}
