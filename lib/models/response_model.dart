import 'dart:ffi';

class ResponseModel<TData> {
  final String? statusCode;
  final bool succeeded;
  final TData? data;
  final List<dynamic>? errors;

  ResponseModel(
      {this.statusCode, required this.succeeded, this.data, this.errors});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      statusCode: json['statusCode'],
      succeeded: json['succeeded'],
      data: json['data'],
      errors: json['errors'],
    );
  }
}
