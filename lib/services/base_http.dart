import 'dart:convert';

import 'package:chatkid_mobile/config.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class BaseHttp {
  static BaseHttp? _instance;
  static const String apiVersion = "1.0";
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
        if (value != null) {
          url += "$key=$value&";
        }
      });
      // url = url.substring(0, url.length - 1);
    }
    return url;
  }

  Future<Map<String, String>> _getHeaders(Map<String, String>? headers) async {
    String token = await AuthService.getAccessToken();

    return {
      "Content-Type": "application/json",
      "Accept": "application/json, text/plain, */*",
      "Authorization": "Bearer $token",
      "api-version": apiVersion,
      ...?headers,
    };
  }

  Future<http.Response> get(
      {required String endpoint,
      Map<String, dynamic>? param,
      Map<String, String>? headers}) async {
    String url = _combineUrl(endpoint, param);
    final combineHeaders = await _getHeaders(headers);
    return await http.Client()
        .get(
      Uri.parse(url),
      headers: combineHeaders,
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
      headers: await _getHeaders(headers),
    )
        .catchError((err, s) {
      Logger().e(err, stackTrace: s);
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
      headers: await _getHeaders(headers),
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
      headers: await _getHeaders(headers),
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
