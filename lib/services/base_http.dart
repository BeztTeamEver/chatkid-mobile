import 'dart:convert';

import 'package:chatkid_mobile/config.dart';
import 'package:http/http.dart' as http;

class BaseHttp {
  static BaseHttp? _instance;

  BaseHttp._internal();

  static BaseHttp get instance {
    _instance ??= BaseHttp._internal();
    return _instance!;
  }

  String _combineUrl(String enpoint, Map<String, dynamic>? param) {
    String url = Env.apiUrl + enpoint;
    if (param != null) {
      url += "?";
      param.forEach((key, value) {
        url += "$key=$value&";
      });
      url = url.substring(0, url.length - 1);
    }
    return url;
  }

  Map<String, String> _getHeaders(Map<String, String>? headers) {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer",
      "Accept": "application/json, text/plain, */*",
      ...?headers,
    };
  }

  Future<http.Response> get(
      {required String endpoint,
      Map<String, dynamic>? param,
      Map<String, String>? headers}) async {
    String url = _combineUrl(endpoint, param);
    return await http.Client().get(
      Uri.parse(url),
      headers: _getHeaders(headers),
    );
  }

  Future<http.Response> post(
      {required String endpoint,
      Map<String, dynamic>? param,
      Map<String, String>? headers,
      String? body}) async {
    String url = _combineUrl(endpoint, param);
    return await http
        .post(
      Uri.parse(url),
      body: body,
      headers: _getHeaders(headers),
    )
        .timeout(
      const Duration(seconds: 3),
      onTimeout: () {
        throw Exception('The connection has timed out, Please try again!');
      },
    );
  }

  Future<http.Response> put(
      {required String endpoint,
      Map<String, dynamic>? param,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    String url = _combineUrl(endpoint, param);
    return await http.put(
      Uri.parse(url),
      body: body,
      headers: _getHeaders(headers),
    );
  }

  Future<http.Response> delete(
      {required String endpoint,
      Map<String, dynamic>? param,
      Map<String, String>? headers}) async {
    String url = _combineUrl(endpoint, param);
    return await http.delete(
      Uri.parse(url),
      headers: _getHeaders(headers),
    );
  }
}
