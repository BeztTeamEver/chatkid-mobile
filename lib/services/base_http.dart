import 'dart:convert';

import 'package:chatkid_mobile/config.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:http/http.dart' as http;

class BaseHttp {
  static BaseHttp? _instance;
  LocalStorage _localStorage = LocalStorage.instance;

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
    String token =
        _localStorage.getToken() != null ? _localStorage.getToken()!.token : "";
    if (token.isEmpty) {
      token = _localStorage.preferences.getString("accessToken") ?? "";
    }
    return {
      "Content-Type": "application/json",
      "Accept": "application/json, text/plain, */*",
      "authorization": "$token",
      ...?headers,
    };
  }

  Future<http.Response> get(
      {required String endpoint,
      Map<String, dynamic>? param,
      Map<String, String>? headers}) async {
    String url = _combineUrl(endpoint, param);
    return await http.Client()
        .get(
      Uri.parse(url),
      headers: _getHeaders(headers),
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw Exception('Connection Timeout!');
      },
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
        .catchError((err) {
      print(err.toString());
      throw Exception(err);
    }).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw Exception('Connection Timeout!');
      },
    );
  }

  Future<http.Response> put(
      {required String endpoint,
      Map<String, dynamic>? param,
      Map<String, String>? headers,
      String? body}) async {
    String url = _combineUrl(endpoint, param);
    return await http
        .put(
      Uri.parse(url),
      body: body,
      headers: _getHeaders(headers),
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw Exception('Connection Timeout!');
      },
    );
  }

  Future<http.Response> delete(
      {required String endpoint,
      Map<String, dynamic>? param,
      Map<String, String>? headers,
      String? body}) async {
    String url = _combineUrl(endpoint, param);
    return await http
        .delete(
      Uri.parse(url),
      headers: _getHeaders(headers),
      body: body,
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw Exception('Connection Timeout!');
      },
    );
  }
}
