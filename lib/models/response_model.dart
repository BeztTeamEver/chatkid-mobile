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
